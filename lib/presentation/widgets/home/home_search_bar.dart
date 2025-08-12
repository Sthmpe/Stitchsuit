import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final borderColor = const Color(0xFFE5E7EB);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 1.w),
        ),
        child: TextField(
          textInputAction: TextInputAction.search,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: 'Search for tailors, styles, or fabrics...',
            hintStyle: TextStyle(color: const Color(0xFF9AA0A6), fontSize: 14.sp),
            prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor, size: 20.sp),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.tune_rounded, color: const Color(0xFF9AA0A6), size: 20.sp),
              tooltip: 'Filter',
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          ),
        ),
      ),
    );
  }
}
