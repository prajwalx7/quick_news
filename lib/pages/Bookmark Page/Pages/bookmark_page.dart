import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0C0C0C),
      body: Center(child: Text('Bookmark Page',style: TextStyle(color: Colors.white),),),
    );
  }
}
