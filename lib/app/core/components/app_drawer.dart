import 'package:flutter/material.dart';
import 'package:metal_forte/app/app_controller.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/enums/app_module.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';
import 'package:metal_forte/app/modules/base/base_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamOut<AppModule>(
        stream: baseCtrl.moduleStream.listen,
        builder: (_, module) => Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: const SizedBox(),
                    currentAccountPicture: const CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    currentAccountPictureSize: const Size(60, 60),
                    decoration: BoxDecoration(color: AppColors.primaryDark),
                    accountName: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        appCtrl.usuario.cgc ?? '',
                      ),
                    ),
                  ),
                  for (var item in AppModule.values)
                    ListTile(
                      onTap: () {
                        pop(context);
                        baseCtrl.moduleStream.add(item);
                      },
                      leading: Icon(item.icon,
                          color: item == module ? AppColors.primaryMain : null),
                      title: Text(
                        item.label,
                        style: TextStyle(
                            color:
                                item == module ? AppColors.primaryMain : null),
                      ),
                    )
                ],
              ),
            ),
            ListTile(
              onTap: () => appCtrl.onLogout(context),
              leading: Icon(Icons.exit_to_app, color: AppColors.error),
              title: Text(
                'Sair',
                style: TextStyle(color: AppColors.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
