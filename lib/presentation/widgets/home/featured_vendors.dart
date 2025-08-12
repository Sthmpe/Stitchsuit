import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedVendors extends StatelessWidget {
  const FeaturedVendors({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Silk Paradise', 'Premium Silk'),
      ('Cotton Co.', 'Organic Cotton'),
      ('Wool Masters', 'Fine Wool'),
      ('Linen Hub', 'Pure Linen'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured Fabric Vendors',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12.w, mainAxisSpacing: 12.h, childAspectRatio: 1.2,
          ),
          itemBuilder: (_, i) => _VendorCard(name: items[i].$1, category: items[i].$2),
        ),
      ],
    );
  }
}

class _VendorCard extends StatelessWidget {
  final String name, category;
  const _VendorCard({required this.name, required this.category});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        //border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: brand.withOpacity(.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.store_rounded, color: brand, size: 22.sp),
            ),
            SizedBox(height: 10.h),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2D3748))),
            SizedBox(height: 4.h),
            Text(category,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF5F6368))),
          ],
        ),
      ),
    );
  }
}
