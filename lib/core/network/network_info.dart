import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfo {
  final InternetConnection _connectionChecker = InternetConnection();

  Future<bool> isConnected() async {
    return await _connectionChecker.hasInternetAccess;
  }

  Stream<bool> get stream => _connectionChecker.onStatusChange.map(
        (status) => status == InternetStatus.connected,
      );

  void openStream() {
    _connectionChecker.onStatusChange.listen((status) {
      // Puedes registrar el estado aquí si lo deseas
    });
  }
}
