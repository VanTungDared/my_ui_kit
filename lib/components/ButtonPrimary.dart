import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Widget? icon;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? double.infinity;

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          backgroundColor: bgColor,
          foregroundColor: bgColor,
          side: (isOutlined && borderColor != null)
              ? BorderSide(color: borderColor ?? Colors.white, width: 1.w)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        ),
      ),
    );
  }
}
