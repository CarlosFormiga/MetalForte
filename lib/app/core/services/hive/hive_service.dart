import 'package:hive/hive.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';
import 'package:metal_forte/app/core/enums/storage_status_enum.dart';
import 'package:metal_forte/app/core/models/service_model.dart';
import 'package:metal_forte/app/core/services/hive/hive_box.dart';
import 'package:path_provider/path_provider.dart';

class HiveService extends Service {
  static Future<void> init() async {}

  static void registerAdapters() {
    Hive.registerAdapter<UsuarioModel>(UsuarioModelAdapter());
    Hive.registerAdapter<NfModel>(NfModelAdapter());
    Hive.registerAdapter<NfItemModel>(NfItemModelAdapter());
    Hive.registerAdapter<StorageStatusEnum>(StorageStatusEnumAdapter());
    Hive.registerAdapter<NfAssingModel>(NfAssingModelAdapter());
    Hive.registerAdapter<AppPoint>(AppPointAdapter());
    Hive.registerAdapter<NfAssingProblemModel>(NfAssingProblemModelAdapter());
  }

  @override
  Future<void> initialize() async {
    String path = '${(await getApplicationDocumentsDirectory()).path}/db';
    Hive.init(path);
    registerAdapters();
    await HiveBox.open();
  }
}
