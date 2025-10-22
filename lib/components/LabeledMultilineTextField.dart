import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabeledMultilineTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const LabeledMultilineTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    this.minLines = 4,
    this.maxLines = 6,
    this.helperText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: baseStyle!.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: baseStyle.copyWith(color: Colors.red, fontSize: 13.sp),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? '',
            hintStyle: TextStyle(color: Colors.grey),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.blue, width: 1.2),
            ),
          ),
          onChanged: onChanged,
        ),
        if (helperText != null) ...[
          SizedBox(height: 4.h),
          Text(
            helperText!,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}
