import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';

class Back extends StatelessWidget {
  final bool isOnlyIcon;
  const Back({this.isOnlyIcon = false, super.key});
  const Back.icon({this.isOnlyIcon = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: isOnlyIcon
          ? InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.keyboard_backspace,
                  color: AppColors.black,
                ),
              ),
            )
          : TextButton.icon(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.white),
                  foregroundColor:
                      WidgetStatePropertyAll(AppColors.primaryMain),
                  fixedSize: const WidgetStatePropertyAll(Size(80, 50)),
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 1, vertical: 0))),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.primaryMain,
                size: 20,
              ),
              label: const Text('back'),
            ),
    );
  }
}
