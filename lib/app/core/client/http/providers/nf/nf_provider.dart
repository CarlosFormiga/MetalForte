import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:metal_forte/app/core/client/http/http_client.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';

class NfProvider {
  static Future<List<NfModel>> getNfs(String cmotora) async {
    final response = await dio.get("/rest/XNotas2/integra?CMOTORA=$cmotora",
        options: Options(responseType: ResponseType.bytes));
    final data = jsonDecode(utf8.decode(response.data))['data'];
    return data.map<NfModel>((e) => NfModel.fromMap(e)).toList();
  }

  static Future<void> postNf(Map<String, dynamic> body) async {
    await dio.post("/rest/Xassina2/integra",
        data: body, options: Options(responseType: ResponseType.bytes));
  }
}
