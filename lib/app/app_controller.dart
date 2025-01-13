import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';
import 'package:metal_forte/app/core/data/local/usuario/usuario_data_source.dart';
import 'package:metal_forte/app/core/dialogs/confirm_dialog.dart';
import 'package:metal_forte/app/core/models/app_stream.dart';
import 'package:metal_forte/app/core/models/service_model.dart';

AppController appCtrl = AppController();

class AppController {
  static final AppController _instance = AppController._();

  AppController._();

  factory AppController() => _instance;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  AppStream<UsuarioModel?> usuarioStream = AppStream<UsuarioModel?>();
  UsuarioModel get usuario => usuarioStream.value!;

  bool isInitialized = false;
  Future<void> onInit() async {
    if (isInitialized) return;
    isInitialized = true;
    await Service.initAplicationServices();
    await getUsuario();
    FlutterNativeSplash.remove();
  }

  Future<void> getUsuario() async {
    final result = await UsuarioLocalDataSource.getUsuario();
    usuarioStream.add(result);
  }

  Future<void> onLogout(BuildContext context) async {
    if (!await showConfirmDialog(
        'Tem certeza que deseja sair?', 'As notas fiscais serão apagadas.')) {
      return;
    }
    UsuarioLocalDataSource.deleteUsuario();
    usuarioStream.add(null);
    Navigator.pop(context);
  }
}
