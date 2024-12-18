import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: isLiked
              ? SvgPicture.asset('assets/icons/thumbs_up.svg')
              : SvgPicture.asset('assets/icons/thumbs_up_outlined.svg'),
        ),
        const SizedBox(width: 25),
        GestureDetector(
          onTap: () {
            if (isBookmarked) {
              bookmarkProvider.removeBookmark(widget.article);
            } else {
              bookmarkProvider.addBookmark(widget.article);
            }
          },
          child: isBookmarked
              ? SvgPicture.asset('assets/icons/bookmark.svg')
              : SvgPicture.asset('assets/icons/bookmark_outlined.svg'),
        ),
        const SizedBox(width: 25),
        GestureDetector(
            onTap: () {},
            child: SvgPicture.asset('assets/icons/share_outlined.svg')),
      ],
    );
  }
}
