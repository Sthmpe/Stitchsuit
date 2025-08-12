import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final VoidCallback onCamera;
  final ValueChanged<String>? onChanged;

  const InputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
    required this.onCamera,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    final brand = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.only(bottom: insets > 0 ? 8.h : 12.h),
      child: Container(
        margin: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 0),
        padding:  EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: const Color(0xFFE9ECEF)),
        ),
        child: Row(
          children: [
            IconButton(onPressed: onAttach, icon: Icon(Icons.attach_file, size: 20.sp, color: const Color(0xFF6B7280))),
            IconButton(onPressed: onCamera, icon: Icon(Icons.camera_alt_outlined, size: 20.sp, color: const Color(0xFF6B7280))),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Write a message',
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xFFADB5BD)),
                ),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: 40.w, height: 40.w,
                decoration: BoxDecoration(color: brand, shape: BoxShape.circle),
                child: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class InputBar extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onSend;
//   final VoidCallback onAttach;
//   final VoidCallback onCamera;

//   const InputBar({
//     super.key,
//     required this.controller,
//     required this.onSend,
//     required this.onAttach,
//     required this.onCamera,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final brand = Theme.of(context).primaryColor;
//     return SafeArea(
//       top: false,
//       child: Container(
//         padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
//         color: Colors.white,
//         child: Row(
//           children: [
//             IconButton(
//               onPressed: onAttach,
//               icon: Icon(Icons.attach_file_outlined, color: const Color(0xFF6B7280), size: 22.sp),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF3F4F6),
//                   borderRadius: BorderRadius.circular(24.r),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12.w),
//                 child: TextField(
//                   controller: controller,
//                   minLines: 1,
//                   maxLines: 5,
//                   textInputAction: TextInputAction.newline,
//                   decoration: InputDecoration(
//                     hintText: 'Message…',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xFF9AA0A6)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//             GestureDetector(
//               onTap: onSend,
//               child: Container(
//                 width: 40.w, height: 40.w,
//                 decoration: BoxDecoration(color: brand, shape: BoxShape.circle),
//                 child: Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
