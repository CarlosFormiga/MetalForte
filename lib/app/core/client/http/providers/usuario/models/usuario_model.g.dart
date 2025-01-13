// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioModelAdapter extends TypeAdapter<UsuarioModel> {
  @override
  final int typeId = 0;

  @override
  UsuarioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsuarioModel(
      perfil: fields[0] as String?,
      deviceToken: fields[1] as String?,
      darkMode: fields[2] as bool?,
      dataUltimaConexao: fields[3] as String?,
      ipAcesso: fields[4] as String?,
      ipCidade: fields[5] as String?,
      ipEstado: fields[6] as String?,
      nome: fields[7] as String?,
      senha: fields[8] as String?,
      cgc: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsuarioModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.perfil)
      ..writeByte(1)
      ..write(obj.deviceToken)
      ..writeByte(2)
      ..write(obj.darkMode)
      ..writeByte(3)
      ..write(obj.dataUltimaConexao)
      ..writeByte(4)
      ..write(obj.ipAcesso)
      ..writeByte(5)
      ..write(obj.ipCidade)
      ..writeByte(6)
      ..write(obj.ipEstado)
      ..writeByte(7)
      ..write(obj.nome)
      ..writeByte(8)
      ..write(obj.senha)
      ..writeByte(9)
      ..write(obj.cgc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
