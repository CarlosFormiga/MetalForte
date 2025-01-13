import 'package:metal_forte/app/core/services/notification_service.dart';

class NotificationException implements Exception {
  final String? message;

  NotificationException(this.message);

  void show() {
    NotificationService.showNegative('Erro Encontrado!', message ?? '');
  }
}
