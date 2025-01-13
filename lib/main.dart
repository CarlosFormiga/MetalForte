import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:metal_forte/app/app_widget.dart';
import 'package:metal_forte/app/core/models/notification_exception.dart';
import 'package:metal_forte/app/core/models/service_model.dart';
import 'package:metal_forte/app/core/services/notification_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  PlatformDispatcher.instance.onError = (error, stack) {
    log('Error: $error\n$stack');
    if (error is NotificationException) {
      NotificationService.showNegative('Erro Encontrado',
          error.message ?? 'Não foram encontrados detalhes do erro');
      return false;
    }
    return true;
  };
  await Service.initAplicationServices();
  runApp(const App());
}
