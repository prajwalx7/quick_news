import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff0C0C0C),
        ),
        child: Row(
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Q",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        fontFamily: 'Prompt',
                        color: Colors.white),
                  ),
                  TextSpan(
                    text: "News",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
