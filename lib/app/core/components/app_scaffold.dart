import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';

class AppScaffold extends StatefulWidget {
  final bool resizeAvoid;
  final Widget body;
  final Widget? bottomNav;
  final Widget? fab;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Color? bottomColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? drawer;

  const AppScaffold({
    super.key,
    required this.body,
    this.bottomNav,
    this.fab,
    this.resizeAvoid = false,
    this.appBar,
    this.backgroundColor,
    this.bottomColor,
    this.scaffoldKey,
    this.drawer,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  Color get backgroundColor =>
      widget.backgroundColor ?? const Color(0xFFF67B42);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryMain,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: (widget.bottomColor ?? backgroundColor),
        systemNavigationBarIconBrightness:
            (widget.bottomColor ?? backgroundColor).computeLuminance() > 0.5
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarDividerColor:
            (widget.bottomColor ?? backgroundColor),
        systemNavigationBarContrastEnforced: true,
      ),
      child: Container(
        color: backgroundColor,
        child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
              drawer: widget.drawer,
              key: widget.scaffoldKey,
              appBar: widget.appBar,
              bottomNavigationBar: widget.bottomNav,
              backgroundColor: AppColors.white,
              resizeToAvoidBottomInset: widget.resizeAvoid,
              floatingActionButton: widget.fab,
              body: widget.body),
        ),
      ),
    );
  }
}
