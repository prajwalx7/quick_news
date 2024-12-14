import 'package:flutter/material.dart';
import 'package:quick_news/pages/Bookmark%20Page/Pages/bookmark_page.dart';
import 'package:quick_news/pages/Home%20Page/Pages/home_page.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/custom_bottom_bar.dart';
import 'package:quick_news/pages/Profile%20Page/pages/profile_page.dart';

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
      body: Stack(
        children: [
          _pages[currentIndex],
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child:
                    CustomBottomBar(currentIndex: currentIndex, onTap: _onTap),
              )),
        ],
      ),
    );
  }
}
