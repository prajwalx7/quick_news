import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:quick_news/services/news_service.dart';

class NewsContainer extends StatefulWidget {
  const NewsContainer({super.key});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  late Future<List<dynamic>> _newsArticles;

  @override
  void initState() {
    super.initState();
    _newsArticles = NewsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading news"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No news found"));
          } else {
            final news = snapshot.data!;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: CardSwiper(
                cardsCount: news.length,
                cardBuilder: (context, index, _, __) {
                  final article = news[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF2C5),
                        borderRadius: BorderRadius.circular(18),
                        // border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  article['title'] ?? "No Title", // Headline
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 10),
                                Text(article['publishedAt'] ??
                                    "No Date"), // upload status
                                SizedBox(height: 12),
                                AuthorWidget(
                                  author: article['author'] ?? "No Author",
                                ), // author name
                                SizedBox(height: 15),
                                Text(
                                  article['description'] ??
                                      "No Description", //short description of news
                                  style: TextStyle(fontSize: 22),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 7,
                                ),

                                SizedBox(height: 20),
                              ],
                            ),
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
                },
              ),
            );
          }
        });
  }
}
