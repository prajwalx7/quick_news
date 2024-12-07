import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0C0C0C),
      body: Center(
        child: Text(
          'Seach Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
