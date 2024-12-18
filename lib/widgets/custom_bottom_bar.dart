import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xff393939),
          borderRadius: BorderRadius.circular(42),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Distribute icons evenly
          children: [
            buildIcon('assets/icons/home.svg', 0, widget.currentIndex),
            buildIcon(
                'assets/icons/bookmark_outlined.svg', 1, widget.currentIndex),
            buildIcon('assets/icons/user.svg', 2, widget.currentIndex),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(String svgPath, int index, int currentIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: index == currentIndex
              ? const Color(0xffffffff)
              : const Color(0xff393939),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () => widget.onTap(index),
          child: SvgPicture.asset(
            svgPath,
            colorFilter: ColorFilter.mode(
                index == currentIndex ? Colors.black : Colors.white,
                BlendMode.srcIn),
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
