import 'package:flutter/material.dart';
import 'package:metal_forte/app/app_controller.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/usuario_provider.dart';
import 'package:metal_forte/app/core/data/local/usuario/nf_data_source.dart';
import 'package:metal_forte/app/core/data/local/usuario/usuario_data_source.dart';
import 'package:metal_forte/app/core/services/notification_service.dart';

final signCtrl = SignController();

class SignController {
  static final SignController _instance = SignController._();

  SignController._();

  factory SignController() => _instance;

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future<void> onClickLogin(String cpf, String senha) async {
    try {
      final cpfReplaced = cpf.replaceAll('-', '').replaceAll('.', '');
      final usuario = await UsuarioProvider.getUsuario({
        'DA4_CGC': cpfReplaced,
        'DA4_XSENHA': senha,
      });
      usuario.cgc = cpfReplaced;
      usuario.senha = senha;
      await UsuarioLocalDataSource.saveUsuario(usuario);
      await NfLocalDataSource.clearNfs();
      appCtrl.usuarioStream.add(usuario);
    } catch (e) {
      NotificationService.showNegative(
          'Houve um problema ao realizar o login', e.toString());
    }
  }
}
