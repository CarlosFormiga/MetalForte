import 'package:hive/hive.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';

class HiveBox {
  static late Box<UsuarioModel> usuario;
  static late Box<NfModel> nf;

  static Future<void> open() async {
    usuario = await Hive.openBox<UsuarioModel>('usuario');
    nf = await Hive.openBox<NfModel>('nf');
  }

  static Future<void> clear() async {
    usuario.clear();
    nf.clear();
  }
}
