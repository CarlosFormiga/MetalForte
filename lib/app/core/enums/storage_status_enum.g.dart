// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageStatusEnumAdapter extends TypeAdapter<StorageStatusEnum> {
  @override
  final int typeId = 4;

  @override
  StorageStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StorageStatusEnum.aberta;
      case 1:
        return StorageStatusEnum.pendente;
      case 2:
        return StorageStatusEnum.enviada;
      default:
        return StorageStatusEnum.aberta;
    }
  }

  @override
  void write(BinaryWriter writer, StorageStatusEnum obj) {
    switch (obj) {
      case StorageStatusEnum.aberta:
        writer.writeByte(0);
        break;
      case StorageStatusEnum.pendente:
        writer.writeByte(1);
        break;
      case StorageStatusEnum.enviada:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
