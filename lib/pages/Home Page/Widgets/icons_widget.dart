import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class IconsWidget extends StatefulWidget {
  final Map<String, dynamic> article;
  const IconsWidget({super.key, required this.article});

  @override
  State<IconsWidget> createState() => _IconsWidgetState();
}

class _IconsWidgetState extends State<IconsWidget> {
  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    final isBookmarked = bookmarkProvider.bookmarkedArticles.any(
        (bookmarkedArticle) =>
            bookmarkedArticle['title'] == widget.article['title']);
    bool isLiked = false;
    return Positioned(
      bottom: 5,
      right: 5,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.like_1),
            color: Colors.black,
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            ),
            color: isBookmarked ? Colors.red : Colors.black,
            onPressed: () {
              if (isBookmarked) {
                bookmarkProvider.removeBookmark(widget.article);
              } else {
                bookmarkProvider.addBookmark(widget.article);
              }
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
