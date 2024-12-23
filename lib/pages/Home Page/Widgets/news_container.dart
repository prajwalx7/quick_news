import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_news/pages/Details%20Page/detail_page.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:quick_news/widgets/icons_widget.dart';
import 'package:quick_news/services/news_service.dart';

class NewsContainer extends StatefulWidget {
  final String category;

  const NewsContainer({super.key, required this.category});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  late Future<List<dynamic>> _newsArticles;

  final List<Color> _colors = const [
    Color(0xffFFE8E5),
    Color(0xffFFF2C5),
    Color(0xffE0F1FF),
    Color(0xffEDE5FF),
    Color(0xffE5FFD3),
  ];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  void didUpdateWidget(NewsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _fetchNews();
    }
  }

  void _fetchNews() {
    setState(() {
      _newsArticles = NewsService.fetchNews(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: FutureBuilder<List<dynamic>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Error loading news",
              style: TextStyle(color: Colors.white),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              "No news found",
              style: TextStyle(color: Colors.white),
            ));
          } else {
            final news = snapshot.data!;
            return CardSwiper(
              cardsCount: news.length,
              cardBuilder: (context, index, _, __) {
                final article = news[index];
                final containerColor = _colors[index % _colors.length];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          article: article,
                          backgroundColor: containerColor,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Container(
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  article['title'] ?? "No Title",
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontFamily: 'Prompt',
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 4,
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  article['publishedAt'] ?? "No Date",
                                  style:
                                      const TextStyle(fontFamily: 'Questrial'),
                                ),
                                SizedBox(height: 15.h),
                                AuthorWidget(
                                  author: article['author'] ?? "No Author",
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  article['description'] ?? "No Description",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Questrial',
                                  ),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5.w,
                            child: IconsWidget(article: article),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
