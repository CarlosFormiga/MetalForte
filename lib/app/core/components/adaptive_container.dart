import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/services/keyboard_visible_service.dart';

double? _heightScreen;

class ContainerAdaptive extends StatelessWidget {
  final Widget child;

  const ContainerAdaptive({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => StreamOut<bool>(
            stream: KeyboardVisibleService.isVisible.listen,
            builder: (context, isVisible) => _body(isVisible, constraints)));
  }

  ListView _body(bool isVisible, BoxConstraints constraints) {
    if (!isVisible) _heightScreen = constraints.maxHeight;
    return ListView(
      padding: EdgeInsets.zero,
      physics: isVisible ? null : const NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: _heightScreen ?? constraints.maxHeight,
          width: double.maxFinite,
          child: child,
        )
      ],
    );
  }
}
