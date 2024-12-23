import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff0C0C0C),
        ),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Q",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38.sp,
                        fontFamily: 'Prompt',
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: "News",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
