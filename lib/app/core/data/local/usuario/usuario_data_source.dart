import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';
import 'package:metal_forte/app/core/services/hive/hive_box.dart';

class UsuarioLocalDataSource {
  static Future<UsuarioModel?> getUsuario() async {
    return HiveBox.usuario.values.isEmpty ? null : HiveBox.usuario.values.first;
  }

  static Future<void> saveUsuario(UsuarioModel usuario) async {
    HiveBox.usuario.clear();
    HiveBox.usuario.add(usuario);
  }

  static Future<void> deleteUsuario() async {
    HiveBox.usuario.clear();
  }
}
