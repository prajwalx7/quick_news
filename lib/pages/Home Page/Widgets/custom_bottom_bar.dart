import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(42)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Iconsax.home),
              onPressed: () => widget.onTap(0),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () => widget.onTap(1),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Iconsax.bookmark),
              onPressed: () => widget.onTap(2),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildIcon(IconData icon, VoidCallback onTap) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: const BoxDecoration(color: Color(0xff393939)),
    child: IconButton(
      icon: Icon(icon),
      onPressed: onTap,
    ),
  );
}
