import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    return Container(
     
       margin: EdgeInsets.symmetric(vertical: 3.h).copyWith(
            left: 6.w,
            right: 60.w,
          ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: brand.withOpacity(0.08),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
      ),
      child: SizedBox(
        width: 80.w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Dot(), SizedBox(width: 4.w),
            _Dot(delay: 120), SizedBox(width: 4.w),
            _Dot(delay: 240),
            SizedBox(width: 8.w),
            Text('typing…', style: TextStyle(fontSize: 11.sp, color: brand, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({this.delay = 0});
  @override
  State<_Dot> createState() => _DotState();
}
class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  @override
  void dispose() { _ac.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ac,
      builder: (_, __) {
        final t = ((_ac.value + widget.delay / 900) % 1.0);
        final y = (t < 0.5) ? t * 2 : (1 - t) * 2;
        return Transform.translate(
          offset: Offset(0, -2 * y),
          child: Container(width: 6.r, height: 6.r, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle)),
        );
      },
    );
  }
}
