import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/components/app_drawer.dart';
import 'package:metal_forte/app/core/components/app_loading.dart';
import 'package:metal_forte/app/core/components/app_scaffold.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/enums/app_module.dart';
import 'package:metal_forte/app/modules/base/base_controller.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    baseCtrl.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: baseCtrl.key,
      drawer: const AppDrawer(),
      body: StreamOut(
                    loading: const AppLoading(),
        stream: baseCtrl.moduleStream.listen,
        builder: (_, __) => __.widget,
      ),
    );
  }
}
