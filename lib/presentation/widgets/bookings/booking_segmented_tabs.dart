import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSegmentedTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const BookingSegmentedTabs({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = const ['Upcoming', 'History'];
    final base = const Color(0xFFE5E7EB);
    final selectedColor = Theme.of(context).primaryColor;

    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: base, width: 1.w),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = i == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () => onChanged(i),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? selectedColor.withOpacity(.10) : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  items[i],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: selected ? selectedColor : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
