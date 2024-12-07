import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xffFFF2C5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Technology Breakthrough: AI Predicts Diseases',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text('Updated just now'),
                SizedBox(height: 12),
                AuthorWidget(),
                SizedBox(height: 15),
                Text(
                  'Researchers have unveiled an AI-powered system capable of predicting a variety of diseases using genetic data and lifestyle factors. This innovation is expected to transform preventive healthcare by identifying risks early and enabling personalized treatment plans.',
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 50),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.like_1),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.bookmark),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.share),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
