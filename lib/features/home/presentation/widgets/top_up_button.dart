import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopUpButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TopUpButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
      child: Container(
        height: 50.h,
        width: 0.9.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.theme.primaryColor,
              context.theme.primaryColor.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
