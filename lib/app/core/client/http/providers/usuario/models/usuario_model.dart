import 'dart:convert';
import 'package:hive/hive.dart';
part 'usuario_model.g.dart';

@HiveType(typeId: 0)
class UsuarioModel {
  @HiveField(0)
  String? perfil;
  @HiveField(1)
  String? deviceToken;
  @HiveField(2)
  bool? darkMode;
  @HiveField(3)
  String? dataUltimaConexao;
  @HiveField(4)
  String? ipAcesso;
  @HiveField(5)
  String? ipCidade;
  @HiveField(6)
  String? ipEstado;
  @HiveField(7)
  String? nome;
  @HiveField(8)
  String? senha;
  @HiveField(9)
  String? cgc;

  UsuarioModel({
    this.perfil,
    this.deviceToken,
    this.darkMode,
    this.dataUltimaConexao,
    this.ipAcesso,
    this.ipCidade,
    this.ipEstado,
    this.nome,
    this.senha,
    this.cgc,
  });

  @override
  String toString() {
    return 'UsuarioModel(perfil: $perfil, deviceToken: $deviceToken, darkMode: $darkMode, dataUltimaConexao: $dataUltimaConexao, ipAcesso: $ipAcesso, ipCidade: $ipCidade, ipEstado: $ipEstado, nome: $nome)';
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> data) => UsuarioModel(
        perfil: data['perfil'] as String?,
        deviceToken: data['device_token'] as String?,
        darkMode: data['dark_mode'] as bool?,
        dataUltimaConexao: data['data_ultima_conexao'] as String?,
        ipAcesso: data['ip_acesso'] as String?,
        ipCidade: data['ip_cidade'] as String?,
        ipEstado: data['ip_estado'] as String?,
        nome: data['nome'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'perfil': perfil,
        'device_token': deviceToken,
        'dark_mode': darkMode,
        'data_ultima_conexao': dataUltimaConexao,
        'ip_acesso': ipAcesso,
        'ip_cidade': ipCidade,
        'ip_estado': ipEstado,
        'nome': nome,
        'cgc': cgc,
        'senha' : senha,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UsuarioModel].
  factory UsuarioModel.fromJson(String data) {
    return UsuarioModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UsuarioModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
