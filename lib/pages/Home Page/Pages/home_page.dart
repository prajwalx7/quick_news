import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/app_bar.dart';
import 'package:quick_news/pages/Home%20Page/Pages/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const CustomAppBar(),
            SizedBox(height: 20.h),
            const Expanded(
              child: NewsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
