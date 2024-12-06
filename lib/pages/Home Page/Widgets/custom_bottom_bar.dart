import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(42)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_outlined),
            SizedBox(width: 20),
            Icon(Icons.search_outlined),
            SizedBox(width: 20),
            Icon(Icons.bookmark_outline),
          ],
        ),
      ),
    );
  }
}

Widget buildIcon(IconData icon) {
  return Container(
    decoration: BoxDecoration(color: Colors.grey),
    child: Icon(icon),
  );
}
