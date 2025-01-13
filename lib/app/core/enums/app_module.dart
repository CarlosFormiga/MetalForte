import 'package:flutter/material.dart';
import 'package:metal_forte/app/modules/nf/ui/nfs_page.dart';

enum AppModule {
  nfs,
}

extension AppModuleExt on AppModule {
  Widget get widget {
    switch (this) {
      case AppModule.nfs:
        return const NfsPage();
    }
  }

  IconData get icon {
    switch (this) {
      case AppModule.nfs:
        return Icons.receipt_long;
    }
  }

  String get label {
    switch (this) {
      case AppModule.nfs:
        return 'Notas Fiscais';
    }
  }
}
