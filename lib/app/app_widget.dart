import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/usuario/models/usuario_model.dart';
import 'package:metal_forte/app/core/components/app_loading.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/app_theme.dart';
import 'package:metal_forte/app/modules/base/base_page.dart';
import 'package:metal_forte/app/modules/sign/ui/sign_up_page.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  void initState() {
    _appController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
            color: AppColors.primaryMain,
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
            navigatorKey: _appController.key,
            title: 'Metal Forte',
            home: StreamOutNull<UsuarioModel?>(
                    stream: appCtrl.usuarioStream.listen,
                    loading: const AppLoading(),
                    child: (_, data) =>
                        data == null ? const SignUpPage() : const BasePage(),
                  )));
  }
}
