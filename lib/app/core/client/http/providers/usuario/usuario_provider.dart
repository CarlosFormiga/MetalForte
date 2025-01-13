import 'package:metal_forte/app/core/client/http/http_client.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';

class UsuarioProvider {
  static Future<UsuarioModel> getUsuario(Map<String, dynamic> data) async {
    final response = await dio.post('/rest/XMotori/APP', data: data);
    return UsuarioModel.fromMap(response.data);
  }
}
