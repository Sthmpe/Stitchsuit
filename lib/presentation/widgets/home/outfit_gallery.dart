import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutfitGallery extends StatelessWidget {
  const OutfitGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = const ['Classic Suit', 'Casual Blazer', 'Wedding Tuxedo', 'Business Casual'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Outfit Inspiration',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: titles.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, i) => _OutfitCard(title: titles[i]),
          ),
        ),
      ],
    );
  }
}

class _OutfitCard extends StatelessWidget {
  final String title;
  const _OutfitCard({required this.title});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      width: 150.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
      ),
      child: Stack(
        children: [
          // placeholder gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [brand.withOpacity(.12), brand.withOpacity(.04)],
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
          Center(child: Icon(Icons.image, color: brand, size: 36.sp)),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14.r), bottomRight: Radius.circular(14.r),
                ),
              ),
              child: Text(title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
