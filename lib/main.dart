import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/navigation_page.dart';
import 'package:quick_news/services/bookmark_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BookmarkProvider(),),
    ],
  
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}


