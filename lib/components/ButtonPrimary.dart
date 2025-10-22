import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.height,
    this.width,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? 48.h;
    final buttonWidth = width ?? double.infinity;

    final bgColor = color ?? Colors.orange;
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 18.sp) : const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isOutlined ? bgColor : txtColor,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isOutlined ? Colors.white : bgColor,
          foregroundColor: isOutlined ? bgColor : txtColor,
          side: isOutlined
              ? BorderSide(color: bgColor, width: 1.5.w)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        ),
      ),
    );
  }
}
