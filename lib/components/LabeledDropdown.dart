import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final List<T> options; // 👈 danh sách dữ liệu gốc
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemLabel; // 👈 hàm lấy text hiển thị

  const LabeledDropdown({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    required this.options,
    this.value,
    this.onChanged,
    this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;
    final hasData = options.isNotEmpty;

    // ✅ Tự map danh sách sang DropdownMenuItem
    final items = hasData
        ? options
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    itemLabel != null ? itemLabel!(e) : e.toString(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList()
        : <DropdownMenuItem<T>>[
            DropdownMenuItem<T>(
              value: null,
              enabled: false,
              child: Text(
                "Chưa có dữ liệu",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: label,
            style: baseStyle?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.grey,
              fontSize: 13.sp,
            ),
            children: isRequired
                ? [
                    TextSpan(
                      text: " *",
                      style: baseStyle?.copyWith(
                        color: Colors.red,
                        fontSize: 13.sp,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField2<T>(
          value: hasData ? value : null,
          onChanged: hasData ? onChanged : (val) {},
          items: items,
          isExpanded: true,
          style: baseStyle?.copyWith(
            fontSize: 15.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.h,
              horizontal: 0.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.blue, width: 1.2),
            ),
          ),
          hint: Text(
            hasData ? (hintText ?? "") : "Chưa có dữ liệu",
            style: TextStyle(color: Colors.grey, fontSize: 15.sp),
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 8.w),
            height: 36.h,
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            iconSize: 22.sp,
            iconEnabledColor: Colors.black54,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
