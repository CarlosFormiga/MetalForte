import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:metal_forte/app/core/models/service_model.dart';

class ConnectivityService extends Service {
  static Future<bool> get hasConnection async => !(await Connectivity().checkConnectivity()).contains(ConnectivityResult.none);

  @override
  Future<void> initialize() async {

  }
}
