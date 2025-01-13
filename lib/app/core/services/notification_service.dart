import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:metal_forte/app/core/components/notification_widget.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';

class NotificationService {
  static void showPositive(String title, String subtitle,
          {NotificationPosition position = NotificationPosition.top}) =>
      showOverlayNotification(
          (context) => NotificationWidget(
                title: title,
                subtitle: subtitle,
                color: AppColors.success,
                colorOpacity: const Color(0xFFe4f4e7),
                icon: Icons.done_rounded,
              ),
          position: position,
          duration: const Duration(seconds: 4));

  static void showPending(String title, String subtitle) =>
      showOverlayNotification(
          (context) => NotificationWidget(
                title: title,
                subtitle: subtitle,
                color: AppColors.pending,
                colorOpacity: AppColors.pending.withOpacity(0.13),
                icon: Icons.warning_rounded,
              ),
          position: NotificationPosition.top,
          duration: const Duration(seconds: 4));

  static void showNegative(String title, String subtitle,
          {NotificationPosition position = NotificationPosition.top}) =>
      showOverlayNotification(
          (context) => NotificationWidget(
                title: title,
                subtitle: subtitle,
                color: AppColors.error,
                colorOpacity: AppColors.error.withOpacity(0.80),
                icon: Icons.close_rounded,
              ),
          position: position,
          duration: const Duration(seconds: 4));

  static void showNeutral(String title, String subtitle,
          {NotificationPosition position = NotificationPosition.top}) =>
      showOverlayNotification(
          (context) => NotificationWidget(
                title: title,
                subtitle: subtitle,
                color: const Color(0xFF3faaff),
                icon: Icons.info_outline_rounded,
                colorOpacity: const Color(0xFF3faaff).withOpacity(0.13),
              ),
          position: position,
          duration: const Duration(seconds: 4));
}
