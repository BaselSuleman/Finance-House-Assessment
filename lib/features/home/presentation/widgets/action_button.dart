import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;
  final double elevation;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 45,
    this.iconSize = 28,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? Colors.white;
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.secondary;

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size.sp,
        width: size.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: effectiveBackgroundColor,
        ),

        child: Icon(icon, color: effectiveIconColor, size: iconSize.sp),
      ),
    );
  }
}
