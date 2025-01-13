import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'storage_status_enum.g.dart';

@HiveType(typeId: 4)
enum StorageStatusEnum {
  @HiveField(0)
  aberta,
  @HiveField(1)
  pendente,
  @HiveField(2)
  enviada,
}

extension StorageStatusEnumExtension on StorageStatusEnum {
  String get label {
    switch (this) {
      case StorageStatusEnum.aberta:
        return 'Abertas';
      case StorageStatusEnum.pendente:
        return 'Pendentes';
      case StorageStatusEnum.enviada:
        return 'Enviadas';
    }
  }

  IconData get icon {
    switch (this) {
      case StorageStatusEnum.aberta:
        return Icons.playlist_play;
      case StorageStatusEnum.pendente:
        return Icons.playlist_add;
      case StorageStatusEnum.enviada:
        return Icons.playlist_add_check;
    }
  }

  Color get color {
    switch (this) {
      case StorageStatusEnum.aberta:
        return Colors.green;
      case StorageStatusEnum.pendente:
        return Colors.red;
      case StorageStatusEnum.enviada:
        return Colors.blue;
    }
  }

  Color get bottomNavColor {
    switch (this) {
      case StorageStatusEnum.aberta:
        return Colors.green[100]!;
      case StorageStatusEnum.pendente:
        return Colors.red[100]!;
      case StorageStatusEnum.enviada:
        return Colors.blue[100]!;
    }
  }
}
