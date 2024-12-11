import 'package:flutter/material.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/app_bar.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/filter_list.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/news_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0C0C0C),
      body: Column(
        children: [
          SizedBox(height: 40),
          CustomAppBar(),
          SizedBox(height: 20),
          FilterList(),
          NewsContainer(),
        ],
      ),
    );
  }
}
