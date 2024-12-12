import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/icons_widget.dart';
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
    Color(0xffFEF3E2),
    Color(0xffE0FBE2),
    Color(0xffD4F6FF),
    Color(0xffF6EFBD),
    Color(0xffE7F0DC),
    Color(0xffF5DAD2),
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
      height: 550,
      child: FutureBuilder<List<dynamic>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading news"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No news found"));
          } else {
            final news = snapshot.data!;
            return CardSwiper(
              cardsCount: news.length,
              cardBuilder: (context, index, _, __) {
                final article = news[index];
                final containerColor = _colors[index % _colors.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(18),
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
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 10),
                              Text(article['publishedAt'] ?? "No Date"),
                              const SizedBox(height: 12),
                              AuthorWidget(
                                author: article['author'] ?? "No Author",
                              ),
                              const SizedBox(height: 15),
                              Text(
                                article['description'] ?? "No Description",
                                style: const TextStyle(fontSize: 22),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 7,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const IconsWidget(),
                      ],
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
