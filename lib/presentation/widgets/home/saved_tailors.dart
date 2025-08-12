import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedTailors extends StatelessWidget {
  const SavedTailors({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Sarah Wilson', '4.9'),
      ('Mike Johnson', '4.8'),
      ('Lisa Chen', '4.7'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Saved Tailors',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        SizedBox(
          height: 76.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, i) => _SavedTile(name: items[i].$1, rating: items[i].$2),
          ),
        ),
      ],
    );
  }
}

class _SavedTile extends StatelessWidget {
  final String name, rating;
  const _SavedTile({required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        //border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: brand.withOpacity(.12),
            child: Text(name[0], style: TextStyle(color: brand, fontWeight: FontWeight.w800, fontSize: 12.sp)),
          ),
          SizedBox(width: 8.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
              Text('$rating ★',
                  style: TextStyle(
                      fontSize: 10.sp, fontWeight: FontWeight.w800, color: brand)),
            ],
          ),
        ],
      ),
    );
  }
}
