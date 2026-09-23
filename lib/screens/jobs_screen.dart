import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../config/app_strings.dart';
import '../config/theme.dart';
import '../models/job.dart';
import '../providers/jobs_provider.dart';
import '../widgets/quick_tags.dart';
import '../widgets/empty_states.dart';
import '../widgets/staggered_list_item.dart';
import '../widgets/page_transitions.dart';
import 'job_detail_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final _searchController = TextEditingController();
  String? _activeTag;
  String _sortBy = 'newest';
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  Future<void> _toggleVoiceSearch() async {
    if (_isListening) {
      setState(() => _isListening = false);
      await _speech.stop();
      return;
    }
    final available = await _speech.initialize();
    if (!available) return;
    setState(() => _isListening = true);
    await _speech.listen(
      localeId: 'ar_IQ',
      onResult: (result) {
        setState(() {
          _searchController.text = result.recognizedWords;
          _activeTag = null;
        });
        context.read<JobsProvider>().updateSearch(result.recognizedWords);
      },
      onSoundLevelChange: (_) {},
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        partialResults: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<JobsProvider>();
      if (provider.allJobs.isEmpty) {
        provider.fetchJobs();
      }
    });
  }

  @override
  void dispose() {
    _speech.stop();
    _searchController.dispose();
    super.dispose();
  }

  List<Job> _sortedJobs(List<Job> jobs) {
    final sorted = List<Job>.from(jobs);
    switch (_sortBy) {
      case 'newest':
        sorted.sort((a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
        break;
      case 'oldest':
        sorted.sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
        break;
      case 'salary_high':
        sorted.sort((a, b) => _parseSalary(b.salary).compareTo(_parseSalary(a.salary)));
        break;
      case 'salary_low':
        sorted.sort((a, b) => _parseSalary(a.salary).compareTo(_parseSalary(b.salary)));
        break;
    }
    return sorted;
  }

  int _parseSalary(String? salary) {
    if (salary == null) return 0;
    final cleaned = salary.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          _buildHeader(isDark),
          _buildSearchBar(isDark),
          SizedBox(height: 4),
          QuickSearchTags(
            activeKeyword: _activeTag,
            onTagSelected: (keyword) {
              setState(() {
                if (_activeTag == keyword) {
                  _activeTag = null;
                  _searchController.clear();
                  context.read<JobsProvider>().updateSearch('');
                } else {
                  _activeTag = keyword;
                  _searchController.text = keyword;
                  context.read<JobsProvider>().updateSearch(keyword);
                }
              });
            },
          ),
          _buildSortBar(isDark),
          SizedBox(height: 8),
          Expanded(child: _buildJobsList(isDark)),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 10, offset: Offset(0, 3))]),
            child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/logo/logo.jpg', fit: BoxFit.cover)),
          ),
          SizedBox(width: 12),
          Text(AppStrings.navJobs, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() => _activeTag = null);
          context.read<JobsProvider>().updateSearch(value);
        },
        decoration: InputDecoration(
          hintText: AppStrings.searchJob,
          prefixIcon: Icon(Icons.search_rounded, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary, size: 22),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _isListening
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                    size: 20,
                    color: _isListening
                        ? AppColors.primary
                        : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  ),
                ),
                onPressed: _toggleVoiceSearch,
              ),
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.close_rounded, size: 18, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _activeTag = null);
                    context.read<JobsProvider>().updateSearch('');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortBar(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.sort_rounded, size: 18, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
          SizedBox(width: 6),
          Text(AppStrings.sort, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
          SizedBox(width: 8),
          _sortChip(AppStrings.newest, 'newest', isDark),
          SizedBox(width: 6),
          _sortChip(AppStrings.oldest, 'oldest', isDark),
          SizedBox(width: 6),
          _sortChip(AppStrings.highestSalary, 'salary_high', isDark),
          SizedBox(width: 6),
          _sortChip(AppStrings.lowestSalary, 'salary_low', isDark),
        ],
      ),
    );
  }

  Widget _sortChip(String label, String value, bool isDark) {
    final active = _sortBy == value;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _sortBy = value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.border)),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: active ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary))),
      ),
    );
  }

  Widget _buildJobsList(bool isDark) {
    return Consumer<JobsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Column(children: List.generate(4, (_) => shimmerCard(isDark))));
        }
        if (provider.error != null) {
          return EmptyStates.error(context, onRetry: () => provider.fetchJobs());
        }
        final jobs = _sortedJobs(provider.filteredJobs);
        if (jobs.isEmpty) {
          return provider.searchQuery.isNotEmpty
              ? EmptyStates.noSearchResults(context)
              : EmptyStates.noJobs(context);
        }
        return RefreshIndicator(
          onRefresh: () => provider.fetchJobs(),
          color: AppColors.primary,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return StaggeredListItem(
                index: index,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, PageTransitions.slideRight(JobDetailScreen(job: job))),
                  child: _jobCard(job, isDark),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _jobCard(Job job, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.work_outline_rounded, color: AppColors.primary, size: 20)),
              SizedBox(width: 12),
              Expanded(child: Text(job.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: job.isOpen ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(job.isOpen ? AppStrings.jobOpen : AppStrings.jobClosed, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: job.isOpen ? AppColors.success : AppColors.error)),
              ),
            ],
          ),
          if (job.location != null || job.employmentType != null) ...[
            SizedBox(height: 12),
            Wrap(spacing: 16, runSpacing: 6, children: [
              if (job.location != null) _metaTag(Icons.location_on_outlined, job.location!, isDark),
              if (job.employmentType != null) _metaTag(Icons.access_time_rounded, job.employmentType!, isDark),
              if (job.salary != null) _metaTag(Icons.monetization_on_outlined, job.salary!, isDark),
            ]),
          ],
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.borderLight))),
            child: Row(
              children: [
                Text(AppStrings.viewDetails, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                SizedBox(width: 4),
                Icon(Icons.arrow_back_ios_new, size: 12, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaTag(IconData icon, String text, bool isDark) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
      SizedBox(width: 4),
      Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
    ]);
  }
}
