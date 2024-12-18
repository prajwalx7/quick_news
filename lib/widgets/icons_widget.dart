import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class IconsWidget extends StatefulWidget {
  final Map<String, dynamic> article;
  const IconsWidget({super.key, required this.article});

  @override
  State<IconsWidget> createState() => _IconsWidgetState();
}

class _IconsWidgetState extends State<IconsWidget> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = false;
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final isBookmarked = bookmarkProvider.bookmarkedArticles.any(
        (bookmarkedArticle) =>
            bookmarkedArticle['title'] == widget.article['title']);

    return Positioned(
      bottom: 5,
      right: 5,
      child: Row(
        children: [
          IconButton(
            icon: isLiked
                ? const Icon(
                    Icons.thumb_up,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.black,
                  ),
            onPressed: () {
              setState(() {
                // Toggle the like state on button tap
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
            icon: const Icon(Icons.share),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
