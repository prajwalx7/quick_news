import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/navigation_page.dart';
import 'package:quick_news/services/bookmark_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookmarkProvider()..loadBookmarks(),
      /* ".." cascade notation in dart which allows call method on an object
             immediately after creating it */
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 750),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigationPage(),
      ),
    );
  }
}
