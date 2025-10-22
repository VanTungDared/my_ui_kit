import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isRequired;
  final bool isPassword;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final TextInputType? textType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isRequired = false,
    this.isPassword = false,
    this.isReadOnly = false,
    this.onTap,
    this.suffixIcon,
    this.textType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + Dấu sao đỏ
        RichText(
          text: TextSpan(
            text: label,
            style: baseStyle?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
              color: Colors.grey.shade800,
            ),
            children: isRequired
                ? [
                    TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red, fontSize: 13.sp),
                    ),
                  ]
                : [],
          ),
        ),

        SizedBox(height: 6.h),

        // TextField
        TextField(
          controller: controller,
          obscureText: isPassword,
          readOnly: isReadOnly,
          onTap: onTap,
          keyboardType: textType ?? TextInputType.text,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.orange, width: 1.2.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(
              minWidth: 36.w,
              minHeight: 24.h,
            ),
          ),
        ),
      ],
    );
  }
}
