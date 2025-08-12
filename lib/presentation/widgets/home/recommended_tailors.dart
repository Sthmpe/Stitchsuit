import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedTailors extends StatelessWidget {
  const RecommendedTailors({super.key});

  @override
  Widget build(BuildContext context) {
    final data = const [
      ('Ahmed Hassan', '4.9 ★', 'Expert Suit Maker'),
      ('Maria Santos', '4.8 ★', 'Wedding Specialist'),
      ('John Smith', '4.7 ★', 'Casual Wear Expert'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended Tailors',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, i) => _TailorCard(name: data[i].$1, rating: data[i].$2, specialty: data[i].$3),
          ),
        ),
      ],
    );
  }
}

class _TailorCard extends StatelessWidget {
  final String name, rating, specialty;
  const _TailorCard({required this.name, required this.rating, required this.specialty});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      width: 210.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        //border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: brand.withOpacity(.12),
                child: Text(name[0], style: TextStyle(color: brand, fontWeight: FontWeight.w800, fontSize: 14.sp)),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
                  SizedBox(height: 2.h),
                  Text(rating,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w700, color: brand)),
                  SizedBox(height: 10.h),
                  Text(specialty,
                      style:
                          TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
