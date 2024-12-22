import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/services/bookmark_provider.dart';
import 'package:share_plus/share_plus.dart';

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

  void _shareArticle(BuildContext context) {
    final title = widget.article['title'] ?? 'No title';
    final description = widget.article['description'] ?? 'No description';
    final url = widget.article['url'] ?? 'No url';

    final shareContent = 'Check out this news: \n\n'
        'Headline: $title\n\n'
        'Description: $description\n\n'
        'Read more: $url';

    Share.share(shareContent);
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
              ? SvgPicture.asset(
                  'assets/icons/thumbs_up.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                )
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
            onTap: () {
              _shareArticle(context);
            },
            child: SvgPicture.asset('assets/icons/share_outlined.svg')),
      ],
    );
  }
}
