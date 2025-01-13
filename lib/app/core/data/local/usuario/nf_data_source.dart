import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/services/hive/hive_box.dart';

class NfLocalDataSource {
  static Future<List<NfModel>> getNfs() async => HiveBox.nf.values.toList();

  static Future<void> updateNf(NfModel nf) async {
    await HiveBox.nf.put(nf.id, nf);
    await HiveBox.nf.flush();
  }

  static Future<void> saveNf(NfModel nf) async {
    await HiveBox.nf.put(nf.id, nf);
    await HiveBox.nf.flush();
  }

  static Future<void> clearNfs() async {
    HiveBox.nf.clear();
  }
}
