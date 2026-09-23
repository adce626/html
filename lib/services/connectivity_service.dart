import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._();
  factory ConnectivityService() => _instance;
  ConnectivityService._();

  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get isConnected => _controller.stream;
  bool _isConnected = true;
  bool get currentStatus => _isConnected;

  final _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void init() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      final connected = result != ConnectivityResult.none;
      if (_isConnected != connected) {
        _isConnected = connected;
        _controller.add(connected);
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }

  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _isConnected = result != ConnectivityResult.none;
    return _isConnected;
  }
}
