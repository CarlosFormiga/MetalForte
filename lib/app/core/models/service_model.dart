import 'package:metal_forte/app/core/client/http/http_client.dart';
import 'package:metal_forte/app/core/services/hive/hive_service.dart';
import 'package:metal_forte/app/core/services/keyboard_visible_service.dart';

abstract class Service {
  Future<void> initialize();

  static bool isInitialized = false;

  static final List<Service> _applicationServices = [
    HttpClient(),
    HiveService(),
    KeyboardVisibleService(),
  ];

  static Future<void> initAplicationServices() async {
    if (!isInitialized) {
      isInitialized = true;
      for (Service service in _applicationServices) {
        await service.initialize();
      }
    }
  }
}
