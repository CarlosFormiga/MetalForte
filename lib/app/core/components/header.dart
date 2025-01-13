import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/components/back.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/utils/app_css.dart';

class AppHeader extends StatelessWidget {
  final String title;
  const AppHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Back(),
        Text(title, style: AppCss.display.setHeight(1)),
        const H(32),
      ],
    );
  }
}
