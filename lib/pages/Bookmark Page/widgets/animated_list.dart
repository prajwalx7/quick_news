import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/pages/Bookmark%20Page/widgets/bookmark_container.dart';
import 'package:quick_news/pages/Details%20Page/detail_page.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList({super.key});

  @override
  State<CustomAnimatedList> createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final ScrollController _scrollController = ScrollController();
  final String _searchQuery = '';
  final List<Color> colors = const [
    Color(0xffFFE8E5),
    Color(0xffFFF2C5),
    Color(0xffE0F1FF),
    Color(0xffEDE5FF),
    Color(0xffE5FFD3),
  ];

  final List<bool> isAnimated = [];
  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles =
        Provider.of<BookmarkProvider>(context).bookmarkedArticles;

    final filteredBookmarkedArticles = bookmarkedArticles
        .where((article) =>
            article['title'] != null &&
            article['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (isAnimated.length != filteredBookmarkedArticles.length) {
      isAnimated.clear();
      isAnimated.addAll(
          List.generate(filteredBookmarkedArticles.length, (index) => false));
    }
    return Expanded(
      child: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnStart: 0.05,
        gradientFractionOnEnd: 0.2,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          controller: _scrollController,
          itemCount: filteredBookmarkedArticles.length,
          itemBuilder: (context, index) {
            final article = filteredBookmarkedArticles[index];
            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              tween: Tween<double>(
                  begin: isAnimated[index] ? 0.0 : 1.0,
                  end: isAnimated[index] ? 0.0 : 1.0),
              builder: (context, value, child) {
                Future.delayed(Duration(milliseconds: 100 * index), () {
                  if (mounted && !isAnimated[index]) {
                    setState(() {
                      isAnimated[index] = true;
                    });
                  }
                });
                return Transform.translate(
                  offset: Offset(0, 50 * value),
                  child: Opacity(opacity: 1 - value, child: child),
                );
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        article: article,
                        backgroundColor: colors[index % colors.length],
                      ),
                    ),
                  );
                },
                child: bookamrkContainer(context, article, index),
              ),
            );
          },
        ),
      ),
    );
  }
}
