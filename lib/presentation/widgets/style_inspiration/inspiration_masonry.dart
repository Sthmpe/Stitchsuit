import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../data/models/inspiration_item.dart';
import 'inspiration_pin_card.dart';

class InspirationMasonry extends StatelessWidget {
  final List<InspirationItem> items;
  final int accentStep;
  final bool Function(String id) isSaved;
  final void Function(String id) onToggleSave;
  final void Function(InspirationItem item) onTap;
  final void Function(int step) onAccentStepChange;

  const InspirationMasonry({
    super.key,
    required this.items,
    required this.accentStep,
    required this.isSaved,
    required this.onToggleSave,
    required this.onTap,
    required this.onAccentStepChange,
  });

  static const int _stepPx = 160;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Text(
            'No styles match your filters.',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: const Color(0xFF6B7280)),
          ),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollUpdateNotification && n.metrics.axis == Axis.vertical) {
          final delta = n.scrollDelta ?? 0.0;
          if (delta < 0) {
            final pos = n.metrics.pixels;
            final step = (pos / _stepPx).floor();
            if (step != accentStep) onAccentStepChange(step);
          }
        }
        return false;
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          itemCount: items.length,
          itemBuilder: (_, i) {
            final item = items[i];
            return InspirationPinCard(
              item: item,
              saved: isSaved(item.id),
              onSaveToggle: () => onToggleSave(item.id),
              onTap: () => onTap(item),
              indexSeed: i,
              accentStep: accentStep,
            );
          },
        ),
      ),
    );
  }
}
