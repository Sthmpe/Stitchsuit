import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InspirationSearchFilters extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onOpenFilters;

  const InspirationSearchFilters({
    super.key,
    required this.categories,
    required this.selected,
    required this.onCategoryChanged,
    required this.onQueryChanged,
    required this.onOpenFilters,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    cursorColor: brand,
                    onChanged: onQueryChanged,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search styles, fabrics, tags…',
                      hintStyle: TextStyle(color: const Color(0xFF9AA0A6), fontSize: 14.sp),
                      prefixIcon: Icon(Icons.search, color: brand, size: 20.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Filters',
                  onPressed: onOpenFilters,
                  icon: Icon(Icons.tune_rounded, size: 20.sp, color: const Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, i) {
              final label = categories[i];
              final selectedChip = label == selected;
              return ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
                label: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12.sp,
                    color: selectedChip ? brand : const Color(0xFF374151),
                  ),
                ),
                selected: selectedChip,
                backgroundColor: Colors.white,
                selectedColor: brand.withOpacity(.10),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: selectedChip ? brand.withOpacity(.35) : const Color(0xFFE5E7EB),
                  ),
                ),
                onSelected: (_) => onCategoryChanged(label),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
