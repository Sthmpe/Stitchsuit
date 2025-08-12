import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/inspiration_item.dart';

class InspirationPinCard extends StatelessWidget {
  final InspirationItem item;
  final bool saved;
  final VoidCallback onSaveToggle;
  final VoidCallback onTap;
  final int indexSeed;
  final int accentStep;

  const InspirationPinCard({
    super.key,
    required this.item,
    required this.saved,
    required this.onSaveToggle,
    required this.onTap,
    required this.indexSeed,
    required this.accentStep,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    final gradient = _buildSoftGradient(brand, indexSeed, accentStep);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: const Color(0xFFF1F5F9),
                        alignment: Alignment.center,
                        child: Icon(Icons.image_rounded, color: const Color(0xFF9AA0A6), size: 28.sp),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: const Color(0xFFF1F5F9),
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image_rounded, color: const Color(0xFF9AA0A6), size: 26.sp),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      child: InkWell(
                        onTap: onSaveToggle,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            saved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                            color: saved ? brand : const Color(0xFF111827),
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // caption with animated gradient
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), bottomRight: Radius.circular(16.r)),
                gradient: gradient.gradient,
              ),
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800, color: gradient.textColor),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: gradient.dotBg,
                        child: Text(
                          item.author.isNotEmpty ? item.author[0] : '?',
                          style: TextStyle(color: gradient.dotFg, fontSize: 11.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          item.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, color: gradient.subTextColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftGradient {
  final Gradient gradient;
  final Color textColor;
  final Color subTextColor;
  final Color dotBg;
  final Color dotFg;

  _SoftGradient({
    required this.gradient,
    required this.textColor,
    required this.subTextColor,
    required this.dotBg,
    required this.dotFg,
  });
}

_SoftGradient _buildSoftGradient(Color brand, int indexSeed, int step) {
  final base = HSLColor.fromColor(brand);
  final seed = (indexSeed * 92821 + step * 48611) & 0xFFFF;

  double hueShift = ((seed % 21) - 10).toDouble();            // -10..10
  double satShift = ((((seed >> 4) % 13) - 6) / 100.0);       // -0.06..0.06
  double lightA   = ((((seed >> 8) % 17) - 8) / 100.0);       // -0.08..0.08
  double lightB   = ((((seed >> 12) % 17) - 8) / 100.0);

  HSLColor toneA = base
      .withHue((base.hue + hueShift) % 360)
      .withSaturation((base.saturation + satShift).clamp(0.0, 1.0))
      .withLightness((base.lightness + lightA).clamp(0.0, 1.0));
  HSLColor toneB = base
      .withHue((base.hue - hueShift) % 360)
      .withSaturation((base.saturation - satShift).clamp(0.0, 1.0))
      .withLightness((base.lightness + lightB).clamp(0.0, 1.0));

  final c1 = toneA.toColor().withOpacity(0.12);
  final c2 = toneB.toColor().withOpacity(0.06);

  const dirs = [
    (Alignment.topLeft, Alignment.bottomRight),
    (Alignment.bottomLeft, Alignment.topRight),
    (Alignment.topCenter, Alignment.bottomCenter),
    (Alignment.centerLeft, Alignment.centerRight),
  ];
  final dir = dirs[(seed >> 2) % dirs.length];

  final text = const Color(0xFF111827);
  final sub  = const Color(0xFF374151);
  final dotBg = c1.withOpacity(0.25);
  final dotFg = base.toColor();

  return _SoftGradient(
    gradient: LinearGradient(begin: dir.$1, end: dir.$2, colors: [c1, c2]),
    textColor: text,
    subTextColor: sub,
    dotBg: dotBg,
    dotFg: dotFg,
  );
}
