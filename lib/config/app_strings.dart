import 'package:flutter/material.dart';

class AppStrings {
  static Locale _currentLocale = const Locale('ar', 'IQ');

  static void setLocale(Locale locale) => _currentLocale = locale;

  static String get(String ar, String en) {
    return _currentLocale.languageCode == 'en' ? en : ar;
  }

  // ─── GENERAL ────────────────────────────────────────
  static String get appName => get('سما انوار الهدى', 'Sama Al-Noor Al-Huda');
  static String get appNameFull => get('سما انوار الهدى للخدمات العامة', 'Sama Al-Noor Al-Huda General Services');
  static String get companyName => get('سما انوار الهدى', 'Sama Al-Noor Al-Huda');
  static String get companyDesc => get('للخدمات العامة', 'General Services');

  // ─── BOTTOM NAV ─────────────────────────────────────
  static String get navHome => get('الرئيسية', 'Home');
  static String get navServices => get('الخدمات', 'Services');
  static String get navJobs => get('الوظائف', 'Jobs');
  static String get navWorker => get('طلب عامل', 'Request Worker');

  // ─── HOME SCREEN ────────────────────────────────────
  static String get homeTagline => get('شركة خدمات عامة', 'General Services Company');
  static String get homeDesc => get('نقدم أفضل خدمات التنظيف والتغذية والنقل والتوصيل والعمالة والإعلان في كربلاء والمحافظات المجاورة بأعلى معايير الجودة والاحترافية', 'We provide the best cleaning, catering, transport, delivery, labor and advertising services in Karbala with the highest standards of quality and professionalism');
  static String get contactUs => get('اتصل بنا', 'Contact Us');
  static String get aboutUs => get('من نحن', 'About Us');
  static String get homeAboutDesc => get('متعددة الخدمات... بهوية واحدة وثقة تسبق كل معاملة.', 'Multiple services... one identity and trust that precedes every transaction.');
  static String get readMore => get('اقرأ المزيد', 'Read More');
  static String get ourServices => get('خدماتنا', 'Our Services');
  static String get latestJobs => get('آخر الوظائف', 'Latest Jobs');
  static String get noJobsAvailable => get('لا توجد وظائف متاحة حالياً', 'No jobs available right now');
  static String get jobOpen => get('متاحة', 'Open');
  static String get jobClosed => get('مغلقة', 'Closed');
  static String get whySama => get('لماذا سما؟', 'Why Sama?');
  static String get highQuality => get('جودة عالية', 'High Quality');
  static String get highQualityDesc => get('نلتزم بأعلى معايير الجودة في كل خدمة', 'We commit to the highest quality standards in every service');
  static String get fastExecution => get('سرعة التنفيذ', 'Fast Execution');
  static String get fastExecutionDesc => get('ننجز أعمالكم في أسرع وقت ممكن', 'We complete your work as quickly as possible');
  static String get support247 => get('دعم متواصل', '24/7 Support');
  static String get support247Desc => get('فريق دعم متواصل على مدار الساعة', 'A support team available around the clock');
  static String get bestPrices => get('أسعار منافسة', 'Competitive Prices');
  static String get bestPricesDesc => get('نقدم أفضل الأسعار في السوق', 'We offer the best prices in the market');
  static String get requestWorker => get('طلب عامل', 'Request Worker');
  static String get requestWorkerDesc => get('أرسل طلبك وسنتواصل معك فوراً', 'Send your request and we will contact you immediately');

  // ─── SERVICES SCREEN ────────────────────────────────
  static String get allServices => get('جميع الخدمات', 'All Services');
  static String get allServicesDesc => get('من تنظيف وتغذية إلى نقل وتوصيل', 'From cleaning and catering to transport and delivery');
  static String get searchService => get('ابحث عن خدمة...', 'Search for a service...');
  static String get noResults => get('لم نجد نتائج', 'No results found');
  static String get contactWithUs => get('تواصل معنا', 'Contact Us');
  static String get phone => get('الهاتف', 'Phone');
  static String get email => get('البريد', 'Email');
  static String get followUs => get('تابعنا', 'Follow Us');

  // ─── JOBS SCREEN ────────────────────────────────────
  static String get searchJob => get('ابحث عن وظيفة، شركة، منطقة...', 'Search for a job, company, area...');
  static String get sort => get('ترتيب:', 'Sort:');
  static String get newest => get('الأحدث', 'Newest');
  static String get oldest => get('الأقدم', 'Oldest');
  static String get highestSalary => get('أعلى راتب', 'Highest Salary');
  static String get lowestSalary => get('أدنى راتب', 'Lowest Salary');
  static String get viewDetails => get('عرض التفاصيل', 'View Details');

  // ─── JOB DETAIL ─────────────────────────────────────
  static String get jobDetails => get('تفاصيل الوظيفة', 'Job Details');
  static String get location => get('الموقع', 'Location');
  static String get employmentType => get('نوع التوظيف', 'Employment Type');
  static String get salary => get('الراتب', 'Salary');
  static String get department => get('القسم', 'Department');
  static String get company => get('الشركة', 'Company');
  static String get description => get('الوصف', 'Description');
  static String get notSpecified => get('غير محدد', 'Not specified');
  static String get applyJob => get('تقديم على الوظيفة', 'Apply for this job');
  static String get jobClosedNow => get('هذه الوظيفة مغلقة حالياً', 'This job is currently closed');
  static String get copiedJob => get('تم نسخ تفاصيل الوظيفة', 'Job details copied');
  static String get fullName => get('الاسم الكامل', 'Full Name');
  static String get enterName => get('أدخل اسمك الكامل', 'Enter your full name');
  static String get nameRequired => get('أدخل اسمك', 'Enter your name');
  static String get phoneNumber => get('رقم الهاتف', 'Phone Number');
  static String get phoneHint => get('0782 586 5514', '0782 586 5514');
  static String get phoneRequired => get('أدخل رقم الهاتف', 'Enter your phone number');
  static String get phoneInvalid => get('رقم الهاتف غير صحيح', 'Invalid phone number');
  static String get idFront => get('صورة الهوية (الأمام)', 'ID Image (Front)');
  static String get idBack => get('صورة الهوية (الخلف)', 'ID Image (Back)');
  static String get tapToUploadFront => get('اضغط لرفع صورة الهوية الأمامية', 'Tap to upload front ID image');
  static String get tapToUploadBack => get('اضغط لرفع صورة الهوية الخلفية', 'Tap to upload back ID image');
  static String get imageFormat => get('JPG أو PNG — بحد أقصى 5MB', 'JPG or PNG — Max 5MB');
  static String get sending => get('جارٍ الإرسال...', 'Sending...');
  static String get submitApplication => get('إرسال التقديم', 'Submit Application');
  static String get imageSelected => get('تم اختيار الصورة', 'Image selected');
  static String get chooseSource => get('اختر المصدر', 'Choose source');
  static String get camera => get('الكاميرا', 'Camera');
  static String get gallery => get('المعرض', 'Gallery');
  static String get successSubmit => get('تم إرسال طلبك بنجاح! سنتواصل معك قريباً.', 'Your application has been submitted successfully! We will contact you soon.');
  static String get errorTryAgain => get('حدث خطأ — حاول مرة أخرى', 'An error occurred — try again');

  // ─── WORKER REQUEST ─────────────────────────────────
  static String get workerRequest => get('طلب عامل', 'Request Worker');
  static String get workerHeroTitle => get('أرسل طلبك للحصول\nعلى عامل مناسب', 'Send your request to get\na suitable worker');
  static String get workerHeroDesc => get('أرسل معلوماتك ونوع العامل المطلوب وسنتواصل معك خلال دقائق', 'Send your info and the type of worker needed and we will contact you within minutes');
  static String get callNow => get('اتصل الآن', 'Call Now');
  static String get whatsapp => get('واتساب', 'WhatsApp');
  static String get requestForm => get('نموذج الطلب', 'Request Form');
  static String get requestFormDesc => get('أرسل طلبك الآن — املأ النموذج أدناه وسنتواصل معك في أقرب وقت', 'Send your request now — fill out the form below and we will contact you as soon as possible');
  static String get workerType => get('نوع العمل المطلوب', 'Type of work required');
  static String get workerTypeHint => get('مثال: كهربائي، سباك، نجار، دهّان', 'Example: electrician, plumber, carpenter, painter');
  static String get workerTypeRequired => get('أدخل نوع العمل', 'Enter the type of work');
  static String get workersCount => get('عدد العمال', 'Number of workers');
  static String get offeredSalary => get('الراتب المعروض', 'Offered salary');
  static String get salaryHint => get('مثال: 50,000 دينار يومياً', 'Example: 50,000 dinar daily');
  static String get workTime => get('وقت العمل', 'Work time');
  static String get workTimeHint => get('8 صباحاً - 5 مساءً', '8 AM - 5 PM');
  static String get workLocation => get('موقع العمل', 'Work location');
  static String get locationHint => get('المنطقة أو العنوان', 'Area or address');
  static String get workDate => get('تاريخ بداية العمل (اختياري)', 'Work start date (optional)');
  static String get dateHint => get('يوم/شهر/سنة', 'Day/Month/Year');
  static String get notes => get('ملاحظات إضافية (اختياري)', 'Additional notes (optional)');
  static String get notesHint => get('أي تفاصيل إضافية عن العمل المطلوب...', 'Any additional details about the required work...');
  static String get submitRequest => get('إرسال الطلب', 'Submit Request');
  static String get exitConfirm => get('تأكيد الخروج', 'Confirm Exit');
  static String get exitConfirmDesc => get('لديك تغييرات غير محفوظة. هل تريد الخروج؟', 'You have unsaved changes. Do you want to exit?');
  static String get cancel => get('إلغاء', 'Cancel');
  static String get exit => get('خروج', 'Exit');
  static String get howItWorks => get('كيف يعمل', 'How it works');
  static String get howItWorksDesc => get('خطوات بسيطة للحصول على العامل', 'Simple steps to get the worker');
  static String get step1Title => get('أرسل طلبك', 'Send your request');
  static String get step1Desc => get('املأ النموذج بمعلوماتك ونوع العامل المطلوب والموقع', 'Fill out the form with your info, the type of worker needed and the location');
  static String get step2Title => get('نتواصل معك', 'We contact you');
  static String get step2Desc => get('فريقنا يتواصل معك لتأكيد التفاصيل والموعد المناسب', 'Our team contacts you to confirm details and the appropriate appointment');
  static String get step3Title => get('العامل عندك', 'Worker at your place');
  static String get step3Desc => get('نوفر لك العامل المناسب في الوقت المحدد وبأفضل جودة', 'We provide you with the right worker at the specified time with the best quality');
  static String get successWorker => get('تم إرسال طلبك بنجاح! سنتواصل معك خلال دقائق.', 'Your request has been submitted successfully! We will contact you within minutes.');

  // ─── ABOUT SCREEN ───────────────────────────────────
  static String get aboutTitle => get('عن الشركة', 'About the Company');
  static String get aboutCompanyDesc => get('متعددة الخدمات... بهوية واحدة وثقة تسبق كل معاملة.', 'Multiple services... one identity and trust that precedes every transaction.');
  static String get aboutHistory => get('من نحن', 'Who We Are');
  static String get aboutHistoryText => get('تأسست شركة سما انوار الهدى للخدمات العامة بتاريخ 29 من شهر أيلول لسنة 2022م. وهي عبارة عن كيان قانوني يهدف لتحقيق ربح من خلال القيام بالأنشطة التجارية، والشركة مسجلة تسجيل قانونياً وفقاً لأحكام قانون الشركات رقم 21 لسنة 1997 المعدل.', 'Sama Al-Noor Al-Huda General Services Company was established on September 29, 2022. It is a legal entity aimed at achieving profit through commercial activities, registered in accordance with Company Law No. 21 of 1997 as amended.');
  static String get aboutActivities => get('تشمل أنشطة الشركة إدارة المطاعم والمقاهي، وإدارة المجمعات السكنية والصناعية والأندية الاجتماعية سواء الدوائر الرسمية وشبه الرسمية أو القطاع المختلط والخاص، لتقديم الخدمات التكميلية لها من أعمال الإhestاء والصيانة وتصليحات فنية تشمل أعمال ومهارات التنظيف والحلاقة والنجارة والبناء والميكانيك وكافة الخبرات الأخرى بما يحقق أهداف الشركة واغراضها.', 'The company\'s activities include managing restaurants and cafes, managing residential and industrial complexes and social clubs, whether official, semi-official, mixed or private sectors, providing complementary services including catering, maintenance and technical repairs covering cleaning, barbering, carpentry, construction, mechanics and all other expertise that achieve the company\'s objectives.');
  static String get aboutTransport => get('وفي مجال النقل العام تنقل السلع والبضائع بمختلف أنواعها ومنشآتها ونقل الأشخاص داخل وخارج العراق وبواسطة النقل البحري والبري والجوي. وفي مجال servicios التنظيف القيام بكافة أعمال التنظيف بكل أنواعها للمستشفيات والشركات العامة والخاصة والدوائر الرسمية وغير الرسمية والمدارس والمتنزهات والمعامل والفنادق والأندية والاتحادات والجامعات والطرق والتنظيف الموقعي وكذلك تنظيف الشوارع والأرصفة والجسور والبنايات.', 'In the field of public transport, we transport goods and merchandise of all types and transport people inside and outside Iraq via sea, land and air transport. In the field of cleaning services, we carry out all types of cleaning for hospitals, public and private companies, official and unofficial departments, schools, parks, factories, hotels, clubs, unions, universities, roads and site cleaning as well as cleaning streets, sidewalks, bridges and buildings.');
  static String get achievements => get('إنجازاتنا', 'Our Achievements');
  static String get foundingDate => get('29 أيلول 2022', 'September 29, 2022');
  static String get foundingLabel => get('تاريخ التأسيس', 'Founding Date');
  static String get companyLaw => get('قانون الشركات 21', 'Company Law 21');
  static String get companyLawYear => get('سنة 1997 المعدل', 'Year 1997 Amended');
  static String get principles => get('مبادئنا', 'Our Principles');
  static String get reliability => get('الموثوقية', 'Reliability');
  static String get reliabilityDesc => get('نفي بوعودنا ونلتزم بالمواعيد في كل مرة.', 'We keep our promises and stick to deadlines every time.');
  static String get transparency => get('الشفافية', 'Transparency');
  static String get transparencyDesc => get('تعامل واضح ومباشر دون مفاجآت.', 'Clear and direct dealing without surprises.');
  static String get quality => get('الجودة', 'Quality');
  static String get qualityDesc => get('اهتمام بالتفاصيل في كل خدمة نقدمها.', 'Attention to detail in every service we provide.');
  static String get ourLocation => get('موقعنا', 'Our Location');
  static String get inHeartOfKarbala => get('في قلب كربلاء', 'In the heart of Karbala');
  static String get locationDesc => get('مقر الشركة في كربلاء ونقدم خدماتنا على مستوى المدينة والمناطق المحيطة.', 'Our headquarters is in Karbala and we provide our services throughout the city and surrounding areas.');
  static String get officialLicense => get('الرخصة الرسمية', 'Official License');
  static String get licenseTitle => get('ترخيص رسمي', 'Official License');
  static String get licenseDesc => get('ترخيص رسمي — دائرة العمل والتدريب المهني', 'Official license — Department of Labor and Vocational Training');
  static String get licenseText1 => get('نفخر بأن شركة "سما أنوار الهدى" حاصلة على ترخيص رسمي من دائرة العمل والتدريب المهني في وزارة العمل والشؤون الاجتماعية العراقية، لإنشاء وتشغيل مكتب خاص بتشغيل الأيدي العاملة العراقية، وذلك استناداً إلى قانون العمل رقم (٣٧) لسنة ٢٠١٥ وتعليمات وزارة العمل رقم (١) لسنة ٢٠١٨.', 'We are proud that "Sama Al-Noor Al-Huda" has obtained an official license from the Department of Labor and Vocational Training in the Iraqi Ministry of Labor and Social Affairs, to establish and operate a private office for Iraqi labor employment, in accordance with Labor Law No. (37) of 2015 and Ministry of Labor Directive No. (1) of 2018.');
  static String get licenseText2 => get('هذا الترخيص يؤكد التزامنا الكامل بالضوابط القانونية والمعايير الرسمية في تقديم خدماتنا لتشغيل الأيدي العاملة، بما يضمن حقوق الباحثين عن عمل وأصحاب العمل على حد سواء.', 'This license confirms our full commitment to legal controls and official standards in providing our labor employment services, ensuring the rights of job seekers and employers alike.');
  static String get ministryOfLabor => get('وزارة العمل والشؤون الاجتماعية', 'Ministry of Labor and Social Affairs');
  static String get laborLaw => get('قانون العمل رقم ٣٧ لسنة ٢٠١٥', 'Labor Law No. 37 of 2015');
  static String get laborDirective => get('تعليمات وزارة العمل رقم ١ لسنة ٢٠١٨', 'Ministry of Labor Directive No. 1 of 2018');
  static String get usefulLinks => get('روابط مفيدة', 'Useful Links');
  static String get faq => get('الأسئلة الشائعة', 'FAQ');
  static String get termsOfService => get('شروط الاستخدام', 'Terms of Service');
  static String get privacyPolicy => get('سياسة الخصوصية', 'Privacy Policy');

  // ─── CLEANING SERVICE ───────────────────────────────
  static String get cleaning => get('التنظيف', 'Cleaning');
  static String get cleaningDesc => get('حلول تنظيف متكاملة للمنازل والشركات والمؤسسات بأعلى معايير الجودة.', 'Integrated cleaning solutions for homes, companies and facilities with the highest quality standards.');
  static String get cleaningHero => get('عملية التنظيف', 'Cleaning Process');
  static String get cleaningSectors => get('الجهات والمنشآت التي يخدمها القسم', 'Sectors and facilities served by the department');
  static String get cleaningSectorsDesc => get('لا تقتصر خدمات القسم على المنازل فقط، بل تغطي قطاعات واسعة تشمل جميع أنواع المنشآت والمرافق في كربلاء.', 'The department\'s services are not limited to homes only, but cover wide sectors including all types of facilities and establishments in Karbala.');
  static String get healthFacilities => get('المؤسسات الصحية', 'Health Facilities');
  static String get healthFacilitiesDesc => get('تنظيف وتعقيم المستشفيات الحكومية والأهلية والمراكز الطبية بأعلى معايير النظافة والتعقيم.', 'Cleaning and sanitizing government and private hospitals and medical centers with the highest standards of cleanliness and sanitization.');
  static String get govDepartments => get('الدوائر الرسمية والحكومية', 'Official and Government Departments');
  static String get govDepartmentsDesc => get('تنظيف وتأهيل المقرات الإدارية والوزارية داخل المحافظة باحترافية عالية.', 'Cleaning and rehabilitating administrative and ministerial headquarters within the governorate with high professionalism.');
  static String get residentialProjects => get('المشاريع والمجمعات السكنية', 'Residential Projects and Complexes');
  static String get residentialProjectsDesc => get('تنظيف العمارات الحديثة والمجمعات الاستثمارية والسلالم والمرافق المشتركة.', 'Cleaning modern buildings, investment complexes, stairs and shared facilities.');
  static String get commercialFacilities => get('المرافق التجارية', 'Commercial Facilities');
  static String get commercialFacilitiesDesc => get('تنظيف المولات، الأسواق الكبيرة، الفنادق، والمطاعم بشكل منتظم واحترافي.', 'Regular and professional cleaning of malls, large markets, hotels and restaurants.');
  static String get homesAndApartments => get('المنازل والشقق', 'Homes and Apartments');
  static String get homesAndApartmentsDesc => get('تنظيف شامل للمنازل والشقق السكنية بشكل دوري أو لمرة واحدة حسب الحاجة.', 'Comprehensive cleaning of homes and residential apartments periodically or once as needed.');
  static String get officesAndCompanies => get('المكاتب والشركات', 'Offices and Companies');
  static String get officesAndCompaniesDesc => get('تنظيف المكاتب والشركات والمعامل بأحدث طرق التنظيف والتعقيم.', 'Cleaning offices, companies and factories with the latest cleaning and sanitization methods.');
  static String get cleaningTypes => get('أنواع خدمات التنظيف التي نوفرها', 'Types of cleaning services we provide');
  static String get cleaningTypesDesc => get('نقدم حلولاً مخصصة تناسب حالة كل مبنى واحتياجاته الخاصة.', 'We provide customized solutions to suit the condition and specific needs of each building.');
  static String get continuousService => get('خدمة مستمرة', 'Continuous Service');
  static String get dailyCleaning => get('التنظيف الدوري واليومي', 'Regular and Daily Cleaning');
  static String get dailyCleaningDesc => get('الحفاظ على نظافة المكان وترتيبه بشكل مستمر ودوري. نضمن لك بيئة نظيفة وصحية على مدار أيام الأسبوع.', 'Keeping the place clean and organized continuously and regularly. We ensure a clean and healthy environment throughout the week.');
  static String get dailyFeature1 => get('جلي الأسطح والأرضيات يومياً', 'Daily surface and floor polishing');
  static String get dailyFeature2 => get('مسح وتعقيم الأماكن العامة', 'Cleaning and sanitizing public areas');
  static String get dailyFeature3 => get('تعطير وتعقيم الحمامات والمطابخ', 'Fragrancing and sanitizing bathrooms and kitchens');
  static String get dailyFeature4 => get('ترتيب وتنظيم المكاتب والأماكن', 'Organizing and arranging offices and places');
  static String get dailyFeature5 => get('إيداع النفايات وتنظيف الحاويات', 'Disposing waste and cleaning containers');
  static String get afterWorks => get('بعد الأعمال', 'After Works');
  static String get postConstruction => get('التنظيف بعد الإنشاء (التصفير)', 'Post-construction cleaning');
  static String get postConstructionDesc => get('تنظيف البيوت والمباني الجديدة بعد انتهاء أعمال البناء والديكور لإزالة بقايا الطلاء والإسمنت والأوساخ العالقة.', 'Cleaning new homes and buildings after construction and decoration work to remove paint, cement and stuck dirt residues.');
  static String get postFeature1 => get('إزالة بقايا الطلاء من الأرضيات والجدران', 'Removing paint residues from floors and walls');
  static String get postFeature2 => get('تنظيف الإسمنت والبلاط الجديد', 'Cleaning new cement and tiles');
  static String get postFeature3 => get('إزالة الأتربة والأوساخ العالقة', 'Removing accumulated dust and dirt');
  static String get postFeature4 => get('تنظيف النوافذ والزجاج من بقايا الطلاء', 'Cleaning windows and glass from paint residues');
  static String get postFeature5 => get('التجهيز السكن للسكن أو الاستخدام', 'Preparing the property for living or use');
  static String get deepCleaning => get('تنظيف شامل', 'Comprehensive Cleaning');
  static String get deepCleaningTitle => get('التنظيف العميق', 'Deep Cleaning');
  static String get deepCleaningDesc => get('التركيز على التفاصيل الصعبة والمنسية التي تحتاج عناية מיוחדة واحترافية عالية.', 'Focusing on difficult and forgotten details that need special care and high professionalism.');
  static String get deepFeature1 => get('جلي الأرضيات وتلميعها بأحدث الأجهزة', 'Polishing and glossing floors with the latest equipment');
  static String get deepFeature2 => get('تنظيف وتعقيم المطابخ والحمامات بالكامل', 'Full cleaning and sanitizing of kitchens and bathrooms');
  static String get deepFeature3 => get('تنظيف الواجهات الزجاجية الخارجية', 'Cleaning external glass facades');
  static String get deepFeature4 => get('تعقيم الأماكن الصعبة والمنسية', 'Sanitizing difficult and forgotten places');
  static String get deepFeature5 => get('إعادة اللمعان والنظافة للأسطح', 'Restoring shine and cleanliness to surfaces');
  static String get teamSection => get('آليه العمل والكادر المتخصص', 'Work mechanism and specialized staff');
  static String get teamDesc => get('نضم فريق عمل مدرب ومحترف يضمن تنفيذ المهام بأعلى مستوى من الجودة والكفاءة.', 'We have a trained and professional team that ensures tasks are executed with the highest level of quality and efficiency.');
  static String get specializedTeam => get('كوادر متخصصة', 'Specialized Staff');
  static String get specializedTeamDesc => get('فرق عمل مدربة (عمال وعاملات تنظيف) يتم توزيعهم حسب طبيعة المنشأة والمهمة المطلوبة.', 'Trained work teams (cleaning workers) distributed according to the nature of the facility and the required task.');
  static String get flexibleContracts => get('عقود مرنة', 'Flexible Contracts');
  static String get flexibleContractsDesc => get('تعاقد يومي أو أسبوعي أو شهري أو سنوي حسب احتياجات المؤسسات والشركات.', 'Daily, weekly, monthly or annual contracting according to the needs of institutions and companies.');
  static String get modernEquipment => get('مواد وأجهزة حديثة', 'Modern Materials and Equipment');
  static String get modernEquipmentDesc => get('منظفات ومطهرات عالية الجودة وآلات جلي الأرضيات ومعدات تنظيف الواجهات العالية.', 'High-quality detergents and disinfectants, floor polishing machines and high facade cleaning equipment.');
  static String get continuousSupport => get('دعم مستمر', 'Continuous Support');
  static String get continuousSupportDesc => get('تواصل مباشر ومتابعة مستمرة لضمان رضا العميل عن جودة الخدمة.', 'Direct communication and continuous follow-up to ensure customer satisfaction with service quality.');
  static String get readyForCleanEnv => get('جاهز للحصول على بيئة نظيفة وصحية؟', 'Ready to get a clean and healthy environment?');
  static String get readyForCleanEnvDesc => get('اتصل بنا الآن أو راسلنا عبر واتساب لحجز خدمة التنظيف المناسبة لاحتياجاتك.', 'Call us now or message us via WhatsApp to book the cleaning service that suits your needs.');
  static String get cleaningHeroTag => get('قسم التنظيف', 'Cleaning Department');
  static String get cleaningHeroDesc => get('نقدم حلولاً متكاملة للتنظيف تشمل المنازل والشركات والمؤسسات الطبية والحكومية بأعلى معايير الجودة والاحترافية.', 'We provide comprehensive cleaning solutions including homes, companies, medical and government facilities with the highest standards of quality and professionalism.');
  static String get companySections => get('أقسام الشركة', 'Company Sections');
  static String get discoverServices => get('اكتشف خدماتنا الأخرى', 'Discover our other services');
  static String get oneSectionNote => get('قسم واحد قد يفي بالغرض، لكن الحل المتكامل أفضل.', 'One section may suffice, but the integrated solution is better.');
  static String get catering => get('التغذية', 'Catering');
  static String get cateringDesc => get('إعداد وتقديم الطعام للمناسبات والمؤسسات مع وجبات يومية طازجة.', 'Preparing and serving food for occasions and institutions with fresh daily meals.');
  static String get transport => get('النقل العام', 'Public Transport');
  static String get transportDesc => get('خدمات نقل عام موثوقة للأفراد والشركات.', 'Reliable public transport services for individuals and companies.');
  static String get delivery => get('التوصيل السريع', 'Fast Delivery');
  static String get deliveryDesc => get('توصيل سريع ومرن للطرود والطلبات.', 'Fast and flexible delivery of packages and orders.');
  static String get labor => get('تشغيل الأيدي العاملة', 'Labor Employment');
  static String get laborDesc => get('توفير وإدارة الأيدي العاملة للمشاريع والشركات.', 'Providing and managing labor for projects and companies.');
  static String get advertising => get('الإعلان والترويج', 'Advertising and Promotion');
  static String get advertisingDesc => get('خدمات إعلان وترويج شاملة للشركات والمؤسسات.', 'Comprehensive advertising and promotion services for companies and institutions.');

  // ─── CATERING SERVICE ────────────────────────────────
  static String get cateringHeroTag => get('قسم التغذية', 'Catering Department');
  static String get cateringHeroDesc => get('شركة تمارس نشاطها التجاري في قطاع الأغذية والمطاعم، تركيزها الأساسي على توفير المنتجات الغذائية الطازجة والصحية.', 'A company practicing its commercial activity in the food and restaurant sector, focusing on providing fresh and healthy food products.');
  static String get overview => get('نظرة عامة', 'Overview');
  static String get cateringOverview => get('نظرة عامة', 'Overview');
  static String get cateringDesc1 => get('empresa سما انوار الهدى للتجارة تمارس نشاطها التجاري في قطاع الأغذية والمطاعم، تركيزها الأساسي على توفير المنتجات الغذائية الطازجة والصحية، وتطمح إلى امتلاك سلسلة من المعالم التجارية ذات الجودة الغذائية العالية بالإضافة إلى المعالم التجارية التي تملكها حالياً.', 'Sama Anwar Al-Huda Trading Company practices its commercial activity in the food and restaurant sector. Its primary focus is on providing fresh and healthy food products.');
  static String get cateringDesc2 => get('نسعى لتقديم أفضل المنتجات الغذائية لعملائنا الكرام مع الحفاظ على أعلى معايير الجودة والنظافة وسلامة الغذاء. نعمل على تلبية احتياجات عملائنا من المنتجات الطازجة والصحية بأسعار منافسة وجودة عالمية.', 'We strive to provide the best food products to our valued customers while maintaining the highest standards of quality, cleanliness, and food safety.');
  static String get cateringDesc3 => get('فريقنا المتخصص يعمل بشغف واحترافية لضمان وصول المنتجات الغذائية بأعلى جودة وطزاجة لعملائنا. نلتزم بمعايير السلامة الغذائية في جميع مراحل التخزين والتوزيع والتقديم.', 'Our specialized team works with passion and professionalism to ensure food products reach our customers at the highest quality and freshness.');
  static String get cateringWhy => get('ماذا نقدم في هذا القسم؟', 'What do we offer in this section?');
  static String get cateringP1 => get('وجبات يومية طازجة للشركات والمؤسسات', 'Fresh daily meals for companies and institutions');
  static String get cateringP2 => get('تقديم الطعام للمناسبات والحفلات', 'Food service for events and celebrations');
  static String get cateringP3 => get('التزام بمعايير النظافة وسلامة الغذاء', 'Commitment to hygiene and food-safety standards');
  static String get cateringP4 => get('مرونة في القوائم وتجهيز حسب الطلب', 'Flexible menus tailored to your request');

  // ─── TRANSPORT SERVICE ───────────────────────────────
  static String get transportHeroTag => get('قسم النقل العام', 'Transport Department');
  static String get transportHeroDesc => get('ننقلك وتنقل أغراضك بأمان وموثوقية في جميع أنحاء كربلاء، بأسطول منظم من مركبات مهيأة وجداول واضحة ومواعيد مضمونة.', 'We transport you and your goods safely and reliably across Karbala, with an organized fleet of prepared vehicles.');
  static String get transportDesc1 => get('يوفر قسم النقل العام لدينا خدمات تنقل موثوقة للأفراد والشركات في جميع أنحاء كربلاء. ندير تنقل الموظفين اليومي، ونقل الطلاب، والوفود، والمركبات الخاصة بالفعاليات، ونقل الأغراض، بأسطول منظم من مركبات مهيأة تماماً.', 'Our transport department provides reliable movement services for individuals and businesses across Karbala. We manage employee commutes, student transport, delegations, and goods movement.');
  static String get transportDesc2 => get('سائقون متمرسون وملتزمون يجعلون كل رحلة آمنة ومهذبة، يتبعون المسارات المخطط لها مع الحفاظ على مرونة كافية عندما تتغير الظروف. تُفحص المركبات وتُصان بانتظام.', 'Experienced, committed drivers make every trip safe and courteous, following planned routes while staying flexible when circumstances change.');
  static String get transportDesc3 => get('نعمل مع الشركات والمدارس والفنادق والعائلات لبناء خطة تنقل تناسب احتياجاتهم — من الرحلات لمرة واحدة إلى مسارات يومية متكررة.', 'We work with companies, schools, hotels, and families to build transport plans that match their needs.');
  static String get transportP1 => get('نقل موظفي الشركات والمؤسسات', 'Staff transport for companies and organizations');
  static String get transportP2 => get('نقل الطلاب والمناسبات والوفود', 'Transport for students, events, and delegations');
  static String get transportP3 => get('رحلات منتظمة ضمن المدينة', 'Regular trips within the city');
  static String get transportP4 => get('سائقون ملتزمون ومركبات آمنة', 'Committed drivers and safe vehicles');
  static String get transportReady => get('جاهز للبدء؟', 'Ready to start?');
  static String get transportReadyDesc => get('اتصل بنا الآن أو راسلنا عبر واتساب لحجز خدمة النقل المناسبة لاحتياجاتك.', 'Call us now or message us via WhatsApp to book the transport service that suits your needs.');
  static String get whatWeOffer => get('ماذا نقدم في هذا القسم؟', 'What do we offer in this section?');
  static String get transportWhy => get('ماذا نقدم في هذا القسم؟', 'What do we offer in this section?');
  static String get transportOverview => get('نظرة عامة', 'Overview');

  // ─── DELIVERY SERVICE ────────────────────────────────
  static String get deliveryHeroTag => get('قسم التوصيل السريع', 'Delivery Department');
  static String get deliveryHeroDesc => get('أرسل طلباتك وطرودك ومستنداتك معنا وتصل بسرعة وأمان إلى أي نقطة في كربلاء والمناطق المجاورة.', 'Send your orders, packages, and documents with us and they arrive quickly and safely.');
  static String get deliveryDesc1 => get('يقدم قسم التوصيل السريع لدينا خدمة نقل الطرود والمستندات والطلبات بسرعة ومرونة داخل كربلاء والمناطق المجاورة. من طلبات المطاعم ومشتريات المتاجر إلى المستندات الرسمية والطلبات الأكبر حجماً.', 'Our express delivery department moves packages, documents, and orders quickly and flexibly within Karbala and the surrounding areas.');
  static String get deliveryDesc2 => get('تُتابع كل طلبية وتُؤكد من الاستلام وحتى التسليم. ستعرف متى انطلق مندوبك، وأين وصلت الطلبية، ولحظة استلامها.', 'Every order is tracked and confirmed from pickup to handover. You will know when your courier leaves and where the order is.');
  static String get deliveryDesc3 => get('نلتزم بمواعيد تسليم دقيقة وأسعار منافسة، ونوفر خيارات التوصيل في نفس اليوم والمواعيد المحددة وعند الطلب.', 'We keep delivery times tight and pricing competitive, offering same-day, scheduled, and on-demand options.');
  static String get deliveryP1 => get('توصيل طلبات المطاعم والمتاجر', 'Delivery for restaurants and stores');
  static String get deliveryP2 => get('توصيل المستندات والطرود', 'Documents and package delivery');
  static String get deliveryP3 => get('تغطية أرجاء المدينة', 'Coverage across the city');
  static String get deliveryP4 => get('تتبع ومتابعة لكل طلب', 'Tracking and follow-up on every order');
  static String get deliveryReady => get('جاهز للبدء؟', 'Ready to start?');
  static String get deliveryReadyDesc => get('تواصل معنا الآن للحصول على أفضل خدمات التوصيل.', 'Contact us now for the best delivery services.');

  // ─── WORKFORCE SERVICE ───────────────────────────────
  static String get workforceHeroTag => get('قسم تشغيل الأيدي العاملة', 'Workforce Department');
  static String get workforceHeroDesc => get('أن شركة سما انوار الهدى للتوظيف تعد واحدة من أهم الشركات التي توجد في العراق، وخاصة لدى الشباب حديثي التخرج والغير خريجين وأصحاب الحرف الذين يبحثون عن فرص عمل مناسبة لهم.', 'Sama Anwar Al-Huda Recruitment Company is one of the most important companies in Iraq, especially for young graduates and craftsmen looking for suitable job opportunities.');
  static String get workforceDesc1 => get('أن شركة سما انوار الهدى للتوظيف تعد واحدة من أهم الشركات التي توجد في العراق، وخاصة لدى الشباب حديثي التخرج والغير خريجين وأصحاب الحرف الذين يبحثون عن فرص عمل مناسبة لهم.', 'Sama Anwar Al-Huda Recruitment Company is one of the most important companies in Iraq for young graduates, non-graduates, and craftsmen looking for suitable job opportunities.');
  static String get workforceDesc2 => get('هدفهم الأساسي أن يقوموا بتوفير أكبر عدد من الوظائف في مجالات عديدة ومتنوعة ليستطيع الباحث عن وظيفة أن يجد ضلته.', 'Their primary goal is to provide the largest number of jobs in many and varied fields so that job seekers can find what they are looking for.');
  static String get workforceDesc3 => get('نلتزم بتوفير فرص عمل حقيقية ومتنوعة تشمل جميع القطاعات، من العمالة العامة إلى الكوادر المتخصصة، مع متابعة مستمرة لضمان رضا الباحثين عن العمل وأصحاب العمل على حد سواء.', 'We are committed to providing real and diverse job opportunities across all sectors, from general labor to specialized cadres.');
  static String get workforceP1 => get('توفير فرص عمل في مجالات عديدة ومتنوعة', 'Providing job opportunities in many diverse fields');
  static String get workforceP2 => get('خدمة الشباب حديثي التخرج وغير الخريجين', 'Serving young graduates and non-graduates');
  static String get workforceP3 => get('توفير أصحاب الحرف والخبرات المختلفة', 'Providing craftsmen with various skills');
  static String get workforceP4 => get('القضاء على البطالة من أجل عراق أجمل', 'Eliminating unemployment for a more beautiful Iraq');
  static String get workforceReady => get('جاهز للبدء؟', 'Ready to start?');
  static String get workforceReadyDesc => get('تواصل معنا الآن للحصول على أفضل خدمات تشغيل الأيدي العاملة.', 'Contact us now for the best workforce services.');

  // ─── ADVERTISING SERVICE ─────────────────────────────
  static String get advertisingHeroTag => get('قسم الإعلان والترويج', 'Advertising Department');
  static String get advertisingHeroDesc => get('مما لا شك فيه أن التسويق والترويج والدعاية والإعلان أصبحوا أدوات أساسية في الصناعة والتجارة في هذا العصر.', 'Marketing, promotion, and advertising have become essential tools in industry and commerce in this era.');
  static String get advertisingDesc1 => get('مما لا شك فيه أن التسويق والترويج والدعاية والإعلان أصبحوا أدوات أساسية في الصناعة والتجارة في هذا العصر، بل وصل الأمر إلى أن بعض الشركات تقوم باختيار وكالة الدعاية والإعلان وآلية التسويق قبل البدء في إنتاج المنتج.', 'Marketing, promotion, and advertising have become essential tools in industry and commerce, with some companies choosing their advertising agency before starting production.');
  static String get advertisingDesc2 => get('وبسبب تلك الأهمية، تزايد عدد وكالات الإعلان في السنوات الأخيرة في جميع دول العالم وأصبحت هذه الوكالات هي المنوطة في عملية الدعاية والإعلان والتسويق للمنتج.', 'Due to this importance, the number of advertising agencies has increased in recent years worldwide.');
  static String get advertisingDesc3 => get('وتسعى شركة سما انوار الهدى قسم الإعلان والترويج إلى تنظيم الحفلات والأفلام الوثائقية وتصوير كل ما يخص القطاع الخاص من المجمعات السكنية والفنادق والمولات والمطاعم والمحال التجارية وترويجها.', 'Sama Anwar Al-Huda Advertising Department seeks to organize events, documentaries, and promote private sector establishments.');
  static String get advertisingP1 => get('تصوير وإنتاج الأفلام الوثائقية والWidgetItemات', 'Filming and producing documentaries and widgets');
  static String get advertisingP2 => get('تنظيم الحفلات والمناسبات والفعاليات', 'Organizing parties, occasions and events');
  static String get advertisingP3 => get('التصوير الاحترافي للمنشآت والمشروعات', 'Professional photography of establishments');
  static String get advertisingP4 => get('الترويج عبر منصات التواصل الاجتماعي', 'Promotion via social media platforms');
  static String get servicesHeroLabel => get('خدماتنا', 'Our Services');
  static String get servicesHeroTitle1 => get('ستة أقسام ', 'Six integrated ');
  static String get servicesHeroTitle2 => get('متكاملة', 'sections');
  static String get servicesHeroDesc => get('نغطي احتياجاتك اليومية والمهنية بأقسام متخصصة وطواقم جاهزة', 'We cover your daily and professional needs with specialized departments and ready teams');
  static String get advertisingServicesTitle => get('خدماتنا في الإعلان والترويج', 'Our Advertising and Promotion Services');
  static String get advertisingServicesSub => get('نقدم مجموعة شاملة من الخدمات الإعلانية والتسويقية لتوصيل رسالتك لأكبر عدد من الجمهور المستهدف.', 'We provide a comprehensive range of advertising and marketing services to deliver your message to the largest target audience.');
  static String get adSvc1Title => get('إنتاج الفيديو', 'Video Production');
  static String get adSvc1Desc => get('إنتاج فيديوهات إعلانية احترافية وWidgetItemات ترويجية ومقاطع قصيرة لمنصات التواصل الاجتماعي.', 'Producing professional advertising videos, promotional widgets, and short clips for social media.');
  static String get adSvc2Title => get('الأفلام الوثائقية', 'Documentary Films');
  static String get adSvc2Desc => get('تصوير وإنتاج أفلام وثائقية للمشاريع والشركات والمنشآت التجارية لإبراز أعمالها وإنجازاتها.', 'Filming and producing documentary films for projects, companies, and commercial establishments.');
  static String get adSvc3Title => get('التصوير الاحترافي', 'Professional Photography');
  static String get adSvc3Desc => get('تصوير فوتوغرافي احترافي للمناسبات والفعاليات والمنشآت التجارية بجودة عالية.', 'Professional photography for events, occasions, and commercial establishments with high quality.');
  static String get adSvc4Title => get('تنظيم الحفلات', 'Event Organization');
  static String get adSvc4Desc => get('تنظيم وإدارة الحفلات والمناسبات والفعاليات الخاصة والشركات بأفضل الأساليب.', 'Organizing and managing private and corporate parties, occasions and events with the best methods.');
  static String get adSvc5Title => get('التسويق الرقمي', 'Digital Marketing');
  static String get adSvc5Desc => get('الترويج عبر منصات التواصل الاجتماعي وإدارة الحملات الإعلانية الرقمية.', 'Promotion via social media platforms and managing digital advertising campaigns.');
  static String get adSvc6Title => get('التصميم الإعلاني', 'Advertising Design');
  static String get adSvc6Desc => get('تصميم الملصقات واللافتات والمواد الإعلانية المطبوعة والرقمية.', 'Designing posters, signs, and printed and digital advertising materials.');
  static String get adStat1 => get('عميل سعيد', 'Happy Client');
  static String get adStat2 => get('مشروع منجز', 'Completed Project');
  static String get adStat3 => get('خدمة على مدار الساعة', '24/7 Service');
  static String get adStat4 => get('رضا العملاء', 'Client Satisfaction');
  static String get adCtaTitle => get('هل تريد الترويج لمشروعك؟', 'Want to promote your project?');
  static String get adCtaDesc => get('تواصل معنا الآن للحصول على أفضل خدمات الإعلان والترويج.', 'Contact us now for the best advertising and promotion services.');

  // ─── LEGAL SCREEN ───────────────────────────────────
  static String get termsTitle => get('سياسة الاستخدام والشروط', 'Terms of Use and Conditions');
  static String get privacyTitle => get('سياسة الخصوصية', 'Privacy Policy');

  // ─── ONBOARDING ─────────────────────────────────────
  static String get onboardingSkip => get('تخطي', 'Skip');
  static String get onNext => get('التالي', 'Next');
  static String get onStart => get('ابدأ الآن', 'Start Now');
  static String get onboarding1Title => get('خدمات شاملة', 'Comprehensive Services');
  static String get onboarding1Desc => get('تنظيف، تغذية، نقل، توصيل، تشغيل أيدي عاملة — كل ما تحتاجه في مكان واحد.', 'Cleaning, catering, transport, delivery, labor — everything you need in one place.');
  static String get onboarding2Title => get('كوادر متخصصة', 'Specialized Staff');
  static String get onboarding2Desc => get('فريق عمل مدرب ومحترف جاهز لتنفيذ مهامك بأعلى جودة وكفاءة.', 'A trained and professional team ready to execute your tasks with the highest quality and efficiency.');
  static String get onboarding3Title => get('تواصل سريع', 'Quick Communication');
  static String get onboarding3Desc => get('اطلب خدمتك الآن وتواصل معنا مباشرة عبر الهاتف أو الواتساب.', 'Request your service now and contact us directly via phone or WhatsApp.');

  // ─── MAIN SCREEN ────────────────────────────────────
  static String get noInternet => get('لا يوجد اتصال بالإنترنت', 'No internet connection');

  // ─── EMPTY STATES ───────────────────────────────────
  static String get emptyNoJobs => get('لا توجد وظائف متاحة', 'No jobs available');
  static String get emptyFollowUs => get('تابعنا للحصول على أحدث الفرص', 'Follow us for the latest opportunities');
  static String get emptyNoResults => get('لم نجد نتائج', 'No results found');
  static String get emptyTryDifferent => get('جرّب كلمات مختلفة', 'Try different words');
  static String get emptyNoServices => get('لا توجد خدمات', 'No services');
  static String get emptyComingSoon => get('قريباً إن شاء الله', 'Coming soon');
  static String get emptyCheckConnection => get('تحقق من اتصالك بالإنترنت', 'Check your internet connection');
  static String get emptyRetry => get('أعد المحاولة عند الاتصال', 'Retry when connected');
  static String get retry => get('إعادة المحاولة', 'Retry');

  // ─── SUCCESS DIALOG ─────────────────────────────────
  static String get successTitle => get('تم بنجاح!', 'Success!');
  static String get successMessage => get('تم إرسال طلبك بنجاح. سنتواصل معك قريباً.', 'Your request has been submitted successfully. We will contact you soon.');
  static String get done => get('تم', 'Done');

  // ─── ABOUT (home mini) ──────────────────────────────
  static String get aboutHomeDesc => get(' COMPANY: سما انوار الهدىللخدمات العامة — كربلاء\n\n COMPANY: متعددة الخدمات... بهوية واحدة وثقة تسبق كل معاملة.', 'Sama Al-Noor Al-Huda General Services — Karbala\n\nMultiple services... one identity and trust that precedes every transaction.');
  static String get aboutFounded => get('تأسست بتاريخ 29 أيلول 2022م. شركة قانونية مسجلة وفقاً لأحكام قانون الشركات رقم 21 لسنة 1997 المعدل.', 'Established on September 29, 2022. A legal company registered in accordance with Company Law No. 21 of 1997 as amended.');

  // ─── ERROR ──────────────────────────────────────────
  static String get errorTitle => get('حدث خطأ', 'An error occurred');
  static String get errorDesc => get('حدث خطأ غير متوقع. حاول مرة أخرى.', 'An unexpected error occurred. Try again.');

  // ─── SPLASH ─────────────────────────────────────────
  static String get splashSama => get('سما', 'Sama');
  static String get splashNoor => get('انوار الهدى', 'Al-Noor Al-Huda');
  static String get splashServices => get('للخدمات العامة', 'General Services');

  // ─── NOTIFICATIONS ──────────────────────────────────
  static String get notifications => get('الإشعارات', 'Notifications');
  static String get readAll => get('تحديد الكل كمقروء', 'Mark all read');
  static String get noNotifications => get('لا توجد إشعارات حالياً', 'No notifications');
  static String get noNotificationsDesc => get('ستظهر الإشعارات الجديدة هنا', 'New notifications will appear here');
  static String get notificationTypeJobMatch => get('وظيفة جديدة', 'New Job');
  static String get notificationTypeApplicationUpdate => get('تحديث طلب توظيف', 'Application Update');
  static String get notificationTypeWorkerRequestUpdate => get('تحديث طلب عامل', 'Worker Request Update');
  static String get notificationTypeMessage => get('رسالة من الإدارة', 'Message from Admin');
  static String get notificationTypeAnnouncement => get('إعلان عام', 'Announcement');
  static String get notificationDetails => get('تفاصيل الإشعار', 'Notification Details');
}
