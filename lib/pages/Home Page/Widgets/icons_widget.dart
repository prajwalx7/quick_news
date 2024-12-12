import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class IconsWidget extends StatefulWidget {
  const IconsWidget({super.key});

  @override
  State<IconsWidget> createState() => _IconsWidgetState();
}

class _IconsWidgetState extends State<IconsWidget> {
  bool isLiked = false;
  bool isbookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.like_1),
            color: isLiked ? Colors.red : Colors.black,
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Iconsax.bookmark),
            color: isbookmarked ? Colors.red : Colors.black,
            onPressed: () {
              setState(() {
                isbookmarked = !isbookmarked;
              });
            },
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Iconsax.share),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
