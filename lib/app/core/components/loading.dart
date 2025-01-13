import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color? color;
  final double width;

  const Loading({this.size = 24, this.width = 4, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: width,
          valueColor:
              AlwaysStoppedAnimation<Color>(color ?? AppColors.primaryMain),
        ),
      ),
    );
  }
}
