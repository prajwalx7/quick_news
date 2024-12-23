import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthorWidget extends StatelessWidget {
  final String? author;
  const AuthorWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final String displayAuthor =
        (author?.isNotEmpty ?? false) ? author! : "Unknown Author";
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('assets/icons/user.svg')),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Published by',
                style: TextStyle(fontFamily: 'Prompt'),
              ),
              Text(
                displayAuthor,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Text(
            'Follow',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Prompt'),
          ),
        ),
      ],
    );
  }
}
