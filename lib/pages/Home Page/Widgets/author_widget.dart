import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AuthorWidget extends StatelessWidget {
  final String? author;
  const AuthorWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final String displayAuthor =
        (author?.isNotEmpty ?? false) ? author! : "Unknown Author";
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Iconsax.user),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Published by',
                style: TextStyle(fontFamily: 'Prompt'),
              ),
              Text(
                displayAuthor,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Text(
            'Follow',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Prompt'),
          ),
        ),
      ],
    );
  }
}
