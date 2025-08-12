import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      (Icons.shopping_bag_rounded, 'Order placed for Classic Suit', '2 hours ago'),
      (Icons.star_rounded, 'Rated Ahmed Hassan 5 stars', '1 day ago'),
      (Icons.favorite_rounded, 'Saved Maria Santos to favorites', '2 days ago'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activities',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            //border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            children: List.generate(items.length * 2 - 1, (i) {
              if (i.isOdd) return Divider(height: 22.h, color: const Color(0xFFEAECEF));
              final idx = i ~/ 2;
              return _ActivityItem(icon: items[idx].$1, title: items[idx].$2, time: items[idx].$3);
            }),
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon; final String title; final String time;
  const _ActivityItem({required this.icon, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: brand.withOpacity(.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: brand, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF2D3748))),
              SizedBox(height: 2.h),
              Text(time,
                  style: TextStyle(
                      fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
            ],
          ),
        ),
      ],
    );
  }
}
