import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'package:metal_forte/app/core/enums/storage_status_enum.dart';

part 'nf_model.g.dart';

@HiveType(typeId: 2)
class NfModel extends HiveObject {
  @HiveField(0)
  String f2Filial ='';
  @HiveField(1)
  String f2Doc ='';
  @HiveField(2)
  String? status;
  @HiveField(3)
  String f2Serie;
  @HiveField(4)
  String? f2Cliente;
  @HiveField(5)
  String? a1NReduz;
  @HiveField(6)
  String? f2Loja;
  @HiveField(7)
  String? f2Vend1;
  @HiveField(8)
  String? a1Cgc;
  @HiveField(9)
  String? a1End;
  @HiveField(10)
  String? a1Cep;
  @HiveField(11)
  String? a1Mun;
  @HiveField(12)
  String? a1DDD;
  @HiveField(13)
  String? a1TEL;
  @HiveField(14)
  String? f2Carga;
  @HiveField(15)
  String? dAKMotori;
  @HiveField(16)
  String? dA4Nome;
  @HiveField(17)
  String? dA4NReduz;
  @HiveField(18)
  String? dA4Cgc;
  @HiveField(19)
  String? a3Nome;
  @HiveField(20)
  String? c5MenNota;
  @HiveField(21)
  String? c5OBS;
  @HiveField(22)
  String? c5Vincula;
  @HiveField(23)
  List<NfItemModel> itens;
  @HiveField(24)
  StorageStatusEnum storageStatus;
  @HiveField(25)
  bool editada;
  @HiveField(26)
  NfAssingModel assingModel;
  @HiveField(27)
  String? locatioAtDelivered;

  String get id => f2Filial + f2Serie + f2Doc;
  String get address =>
      [a1End, a1Mun, 'CEP $a1Cep'].where((e) => e != null).join(' - ');

  bool get isAssinada => assingModel.points != null;
  bool get hasFotoCarga => assingModel.fotoCarga != null;
  bool get hasFotoCanhoto => assingModel.fotoCanhoto != null;
  bool get hasProblem => assingModel.problem != null;

  bool get isConcluirAvailable => isAssinada && hasFotoCarga && hasFotoCanhoto;

  Future<Map<String, dynamic>> toPostBody() async => {
        "F2_FILIAL": f2Filial,
        "F2_DOC": f2Doc,
        "F2_SERIE": f2Serie,
        "F2_XASSIN": await assingModel.toImagePoints(),
        "F2_XFCARGA": assingModel.fotoCarga,
        "F2_XFCANHO": assingModel.fotoCanhoto,
        "F2_XFOTOPR": assingModel.problem?.fotoProblema,
        "F2_OBSAPP": assingModel.problem?.message,
        "F2_XGEOLOC": locatioAtDelivered,
        "F2_XDATAE": DateFormat('dd-MM-yyyy').format(DateTime.now()),
        "F2_XHORAE": DateFormat('HH:mm').format(DateTime.now()),
        "F2_XAPPTMS": "E",
      };

  NfModel(
      {required this.f2Filial,
      required this.f2Doc,
      required this.f2Serie,
      required this.editada,
      required this.storageStatus,
      required this.assingModel,
      this.status,
      this.f2Cliente,
      this.a1NReduz,
      this.f2Loja,
      this.f2Vend1,
      this.a1Cgc,
      this.a1End,
      this.a1Cep,
      this.a1Mun,
      this.a1DDD,
      this.a1TEL,
      this.f2Carga,
      this.dAKMotori,
      this.dA4Nome,
      this.dA4NReduz,
      this.dA4Cgc,
      this.a3Nome,
      this.c5MenNota,
      this.c5OBS,
      this.c5Vincula,
      required this.itens});

  factory NfModel.fromMap(Map<String, dynamic> json) => NfModel(
      f2Filial: json['F2_FILIAL'] ?? '',
      f2Doc: json['F2_DOC'] ?? '',
      status: json['STATUS']  ?? '',
      f2Serie: json['F2_SERIE']  ?? '',
      f2Cliente: json['F2_CLIENTE']  ?? '',
      a1NReduz: json['A1_NREDUZ']  ?? '',
      f2Loja: json['F2_LOJA']  ?? '',
      f2Vend1: json['F2_VEND1']  ?? '',
      a1Cgc: json['A1_CGC']  ?? '',
      a1End: json['A1_END']  ?? '',
      a1Cep: json['A1_CEP']  ?? '',
      a1Mun: json['A1_MUN']  ?? '',
      a1DDD: json['A1_DDD']  ?? '',
      a1TEL: json['A1_TEL']  ?? '',
      f2Carga: json['F2_CARGA']  ?? '',
      dAKMotori: json['DAK_MOTORI']  ?? '',
      dA4Nome: json['DA4_NOME']  ?? '',
      dA4NReduz: json['DA4_NREDUZ']  ?? '',
      dA4Cgc: json['DA4_CGC']  ?? '',
      a3Nome: json['A3_NOME']  ?? '',
      c5MenNota: json['C5_MENNOTA']  ?? '',
      c5OBS: json['C5_OBS']  ?? '',
      c5Vincula: json['C5_VINCULA']  ?? '',
      itens: json['ITENS'] != null
          ? (json['ITENS'] as List).map((e) => NfItemModel.fromJson(e)).toList()
          : [],
      editada: false,
      storageStatus: json['STATUS'] == 'P'
          ? StorageStatusEnum.aberta
          : StorageStatusEnum.enviada,
      assingModel: NfAssingModel());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['F2_FILIAL'] = f2Filial;
    data['F2_DOC'] = f2Doc;
    data['STATUS'] = status;
    data['F2_SERIE'] = f2Serie;
    data['F2_CLIENTE'] = f2Cliente;
    data['A1_NREDUZ'] = a1NReduz;
    data['F2_LOJA'] = f2Loja;
    data['F2_VEND1'] = f2Vend1;
    data['A1_CGC'] = a1Cgc;
    data['A1_END'] = a1End;
    data['A1_CEP'] = a1Cep;
    data['A1_MUN'] = a1Mun;
    data['A1_DDD'] = a1DDD;
    data['A1_TEL'] = a1TEL;
    data['F2_CARGA'] = f2Carga;
    data['DAK_MOTORI'] = dAKMotori;
    data['DA4_NOME'] = dA4Nome;
    data['DA4_NREDUZ'] = dA4NReduz;
    data['DA4_CGC'] = dA4Cgc;
    data['A3_NOME'] = a3Nome;
    data['C5_MENNOTA'] = c5MenNota;
    data['C5_OBS'] = c5OBS;
    data['C5_VINCULA'] = c5Vincula;
    data['ITENS'] = itens.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'NfModel(f2Filial: $f2Filial, f2Doc: NF $f2Doc, status: $status, f2Serie: $f2Serie, f2Cliente: $f2Cliente, a1NReduz: $a1NReduz, f2Loja: $f2Loja, f2Vend1: $f2Vend1, a1Cgc: $a1Cgc, a1End: $a1End, a1Cep: $a1Cep, a1Mun: $a1Mun, a1DDD: $a1DDD, a1TEL: $a1TEL, f2Carga: $f2Carga, dAKMotori: $dAKMotori, dA4Nome: $dA4Nome, dA4NReduz: $dA4NReduz, dA4Cgc: $dA4Cgc, a3Nome: $a3Nome, c5MenNota: $c5MenNota, c5OBS: $c5OBS, c5Vincula: $c5Vincula, itens: $itens, storageStatus: $storageStatus, editada: $editada, assingModel: $assingModel, locatioAtDelivered: $locatioAtDelivered)';
  }
}

@HiveType(typeId: 3)
class NfItemModel {
  @HiveField(1)
  String? d2Item;
  @HiveField(2)
  String? d2Cod;
  @HiveField(3)
  String? sDescri;
  @HiveField(4)
  String? d2Um;
  @HiveField(5)
  String? d2Segum;
  @HiveField(6)
  int? d2QTSegum;
  @HiveField(7)
  double? d2Quant;

  NfItemModel(
      {this.d2Item,
      this.d2Cod,
      this.sDescri,
      this.d2Um,
      this.d2Segum,
      this.d2QTSegum,
      this.d2Quant});

  NfItemModel.fromJson(Map<String, dynamic> json) {
    d2Item = json['D2_ITEM'];
    d2Cod = json['D2_COD'];
    sDescri = json['_DESCRI'];
    d2Um = json['D2_UM'];
    d2Segum = json['D2_SEGUM'];
    d2QTSegum = json['D2_QTSEGUM'];
    d2Quant = double.parse((json['D2_QUANT'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['D2_ITEM'] = d2Item;
    data['D2_COD'] = d2Cod;
    data['_DESCRI'] = sDescri;
    data['D2_UM'] = d2Um;
    data['D2_SEGUM'] = d2Segum;
    data['D2_QTSEGUM'] = d2QTSegum;
    data['D2_QUANT'] = d2Quant;
    return data;
  }
}

@HiveType(typeId: 5)
class NfAssingModel {
  @HiveField(0)
  List<AppPoint>? points;
  @HiveField(1)
  String? fotoCarga;
  @HiveField(2)
  String? fotoCanhoto;
  @HiveField(3)
  NfAssingProblemModel? problem;

  Future<String> toImagePoints() async {
    final image = await SignatureController(
            points: points?.map((e) => e.toPoint()).toList())
        .toPngBytes();
    return base64Encode(image!.toList());
  }
}

@HiveType(typeId: 6)
class AppPoint {
  @HiveField(0)
  double x;
  @HiveField(1)
  double y;
  @HiveField(2)
  double pressure;
  @HiveField(3)
  int type;
  AppPoint({
    required this.x,
    required this.y,
    required this.pressure,
    required this.type,
  });

  Point toPoint() => Point(Offset(x, y), PointType.values[type], pressure);
}

extension PointExt on Point {
  AppPoint toAppPoint() => AppPoint(
      x: offset.dx, y: offset.dy, pressure: pressure, type: type.index);
}

@HiveType(typeId: 7)
class NfAssingProblemModel {
  @HiveField(0)
  final bool hasProblem;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final String? fotoProblema;

  NfAssingProblemModel(
      {required this.hasProblem, required this.message, this.fotoProblema});
}
