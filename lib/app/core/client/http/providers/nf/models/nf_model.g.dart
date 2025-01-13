// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nf_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NfModelAdapter extends TypeAdapter<NfModel> {
  @override
  final int typeId = 2;

  @override
  NfModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NfModel(
      f2Filial: fields[0] as String,
      f2Doc: fields[1] as String,
      f2Serie: fields[3] as String,
      editada: fields[25] as bool,
      storageStatus: fields[24] as StorageStatusEnum,
      assingModel: fields[26] as NfAssingModel,
      status: fields[2] as String?,
      f2Cliente: fields[4] as String?,
      a1NReduz: fields[5] as String?,
      f2Loja: fields[6] as String?,
      f2Vend1: fields[7] as String?,
      a1Cgc: fields[8] as String?,
      a1End: fields[9] as String?,
      a1Cep: fields[10] as String?,
      a1Mun: fields[11] as String?,
      a1DDD: fields[12] as String?,
      a1TEL: fields[13] as String?,
      f2Carga: fields[14] as String?,
      dAKMotori: fields[15] as String?,
      dA4Nome: fields[16] as String?,
      dA4NReduz: fields[17] as String?,
      dA4Cgc: fields[18] as String?,
      a3Nome: fields[19] as String?,
      c5MenNota: fields[20] as String?,
      c5OBS: fields[21] as String?,
      c5Vincula: fields[22] as String?,
      itens: (fields[23] as List).cast<NfItemModel>(),
    )..locatioAtDelivered = fields[27] as String?;
  }

  @override
  void write(BinaryWriter writer, NfModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.f2Filial)
      ..writeByte(1)
      ..write(obj.f2Doc)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.f2Serie)
      ..writeByte(4)
      ..write(obj.f2Cliente)
      ..writeByte(5)
      ..write(obj.a1NReduz)
      ..writeByte(6)
      ..write(obj.f2Loja)
      ..writeByte(7)
      ..write(obj.f2Vend1)
      ..writeByte(8)
      ..write(obj.a1Cgc)
      ..writeByte(9)
      ..write(obj.a1End)
      ..writeByte(10)
      ..write(obj.a1Cep)
      ..writeByte(11)
      ..write(obj.a1Mun)
      ..writeByte(12)
      ..write(obj.a1DDD)
      ..writeByte(13)
      ..write(obj.a1TEL)
      ..writeByte(14)
      ..write(obj.f2Carga)
      ..writeByte(15)
      ..write(obj.dAKMotori)
      ..writeByte(16)
      ..write(obj.dA4Nome)
      ..writeByte(17)
      ..write(obj.dA4NReduz)
      ..writeByte(18)
      ..write(obj.dA4Cgc)
      ..writeByte(19)
      ..write(obj.a3Nome)
      ..writeByte(20)
      ..write(obj.c5MenNota)
      ..writeByte(21)
      ..write(obj.c5OBS)
      ..writeByte(22)
      ..write(obj.c5Vincula)
      ..writeByte(23)
      ..write(obj.itens)
      ..writeByte(24)
      ..write(obj.storageStatus)
      ..writeByte(25)
      ..write(obj.editada)
      ..writeByte(26)
      ..write(obj.assingModel)
      ..writeByte(27)
      ..write(obj.locatioAtDelivered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NfModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NfItemModelAdapter extends TypeAdapter<NfItemModel> {
  @override
  final int typeId = 3;

  @override
  NfItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NfItemModel(
      d2Item: fields[1] as String?,
      d2Cod: fields[2] as String?,
      sDescri: fields[3] as String?,
      d2Um: fields[4] as String?,
      d2Segum: fields[5] as String?,
      d2QTSegum: fields[6] as int?,
      d2Quant: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, NfItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.d2Item)
      ..writeByte(2)
      ..write(obj.d2Cod)
      ..writeByte(3)
      ..write(obj.sDescri)
      ..writeByte(4)
      ..write(obj.d2Um)
      ..writeByte(5)
      ..write(obj.d2Segum)
      ..writeByte(6)
      ..write(obj.d2QTSegum)
      ..writeByte(7)
      ..write(obj.d2Quant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NfItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NfAssingModelAdapter extends TypeAdapter<NfAssingModel> {
  @override
  final int typeId = 5;

  @override
  NfAssingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NfAssingModel()
      ..points = (fields[0] as List?)?.cast<AppPoint>()
      ..fotoCarga = fields[1] as String?
      ..fotoCanhoto = fields[2] as String?
      ..problem = fields[3] as NfAssingProblemModel?;
  }

  @override
  void write(BinaryWriter writer, NfAssingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.points)
      ..writeByte(1)
      ..write(obj.fotoCarga)
      ..writeByte(2)
      ..write(obj.fotoCanhoto)
      ..writeByte(3)
      ..write(obj.problem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NfAssingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppPointAdapter extends TypeAdapter<AppPoint> {
  @override
  final int typeId = 6;

  @override
  AppPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPoint(
      x: fields[0] as double,
      y: fields[1] as double,
      pressure: fields[2] as double,
      type: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppPoint obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y)
      ..writeByte(2)
      ..write(obj.pressure)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NfAssingProblemModelAdapter extends TypeAdapter<NfAssingProblemModel> {
  @override
  final int typeId = 7;

  @override
  NfAssingProblemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NfAssingProblemModel(
      hasProblem: fields[0] as bool,
      message: fields[1] as String,
      fotoProblema: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NfAssingProblemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.hasProblem)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.fotoProblema);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NfAssingProblemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
