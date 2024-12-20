import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/services/bookmark_provider.dart';

Widget bookamrkContainer(
    BuildContext context, Map<String, dynamic> article, int index) {
  final List<Color> colors = [
    const Color(0xffFFE8E5),
    const Color(0xffFFF2C5),
    const Color(0xffE0F1FF),
    const Color(0xffEDE5FF),
    const Color(0xffE5FFD3),
  ];
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dismissible(
          key: Key(article['title']),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<BookmarkProvider>(context, listen: false)
                .removeBookmark(article);
          },
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? "No Title",
                  style: const TextStyle(
                    fontSize: 26,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                Text(
                  article['publishedAt'],
                  style: const TextStyle(fontFamily: 'Prompt'),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
