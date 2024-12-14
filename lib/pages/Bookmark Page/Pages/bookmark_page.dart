import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Saved News",
          style: TextStyle(
              fontFamily: 'Questrial', color: Colors.white, fontSize: 26),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff0C0C0C),
      body: Center(
        child: Text(
          'Bookmark Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
