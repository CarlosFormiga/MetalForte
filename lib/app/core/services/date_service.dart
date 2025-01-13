import 'package:intl/date_symbol_data_local.dart';
import 'package:metal_forte/app/core/models/service_model.dart';

class DateService implements Service {
  @override
  Future<void> initialize() async {
    await initializeDateFormatting('pt_BR');
  }
}