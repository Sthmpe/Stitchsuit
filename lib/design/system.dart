import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Skin {
  // flip this to true/false to globally show/hide subtle borders
  static bool lightBorders = false;
}

BoxDecoration cardDecoration({
  Color color = Colors.white,
  double radius = 14,
  Color borderColor = const Color(0xFFE5E7EB),
  bool? bordered, // overrides the global flag if provided
}) {
  final showBorder = bordered ?? Skin.lightBorders;
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.r),
    border: showBorder ? Border.all(color: borderColor) : null,
  );
}

InputDecoration searchDecoration({
  required BuildContext context,
  String hint = 'Search...',
  bool? bordered,
}) {
  final showBorder = bordered ?? Skin.lightBorders;
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: const Color(0xFF9AA0A6), fontSize: 14.sp),
    prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor, size: 20.sp),
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
    // if you want an outline sometimes:
    enabledBorder: showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          )
        : InputBorder.none,
    focusedBorder: showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          )
        : InputBorder.none,
  );
}
