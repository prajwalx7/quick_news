import 'package:flutter/material.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/app_bar.dart';
import 'package:quick_news/pages/Home%20Page/Pages/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0C0C0C),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomAppBar(),
            SizedBox(height: 20),
            Expanded(
              child: NewsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
