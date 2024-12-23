import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_news/pages/Bookmark%20Page/Pages/bookmark_page.dart';
import 'package:quick_news/pages/Home%20Page/Pages/home_page.dart';
import 'package:quick_news/pages/Profile%20Page/profile_page.dart';
import 'package:quick_news/widgets/custom_bottom_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    BookmarkPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _pages[currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0.h),
              child: CustomBottomBar(currentIndex: currentIndex, onTap: _onTap),
            ),
          ),
        ],
      ),
    );
  }
}
