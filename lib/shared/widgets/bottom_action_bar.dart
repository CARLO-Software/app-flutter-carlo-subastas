import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class BottomActionBar extends StatelessWidget {
  final Widget child;

  const BottomActionBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: AppSpacing.screenPadding,
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.border)),
      ),
      child: child,
    );
  }
}
