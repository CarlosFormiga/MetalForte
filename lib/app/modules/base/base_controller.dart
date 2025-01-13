import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';
import 'package:metal_forte/app/core/enums/app_module.dart';
import 'package:metal_forte/app/core/models/app_stream.dart';

final baseCtrl = BaseController();
UsuarioModel get usuario => baseCtrl.usuarioStream.value;

class BaseController {
  static final BaseController _instance = BaseController._();

  BaseController._();

  factory BaseController() => _instance;

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final AppStream<AppModule> moduleStream = AppStream<AppModule>();
  final AppStream<UsuarioModel> usuarioStream = AppStream<UsuarioModel>();
  UsuarioModel get usuario => usuarioStream.value;

  void onInit() async {
    moduleStream.add(AppModule.values.first);
  }
}
