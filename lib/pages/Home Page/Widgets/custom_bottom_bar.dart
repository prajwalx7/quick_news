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
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: const Color(0xff393939),
            borderRadius: BorderRadius.circular(42)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildIcon(Iconsax.home, 0, widget.currentIndex),
            buildIcon(Iconsax.search_normal, 1, widget.currentIndex),
            buildIcon(Iconsax.bookmark, 2, widget.currentIndex),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(IconData icon, int index, int currentIndex) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: index == currentIndex
            ? const Color(0xffffffff)
            : const Color(0xff393939),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: index == currentIndex ? Colors.black : Colors.white,
          size: 24,
        ),
        onPressed: () => widget.onTap(index),
      ),
    );
  }
}
