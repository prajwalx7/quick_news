import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:quick_news/services/news_service.dart';

class NewsContainer extends StatefulWidget {
  const NewsContainer({super.key});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer>
    with TickerProviderStateMixin {
  late AnimationController _likeController;
  late AnimationController _bookmarkController;
  late AnimationController _shareController;

  late Future<List<dynamic>> _newsArticles;
  bool isLiked = false;
  bool isBookmarked = false;
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
    _newsArticles = NewsService.fetchNews();
    _likeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _bookmarkController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _shareController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _likeController.dispose();
    _bookmarkController.dispose();
    _shareController.dispose();
    super.dispose();
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
                  final containerColor = _colors[index % _colors.length];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: containerColor,
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
                                  onPressed: () {
                                    _likeController
                                        .forward()
                                        .then((_) => _likeController.reverse());
                                  },
                                  icon: Lottie.asset(
                                    'assets/animations/like.json',
                                    
                                    height: 30,
                                    width: 30,
                                    controller: _likeController,
                                    repeat: false,
                                    animate: true,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _bookmarkController.forward().then(
                                        (_) => _bookmarkController.reverse());
                                  },
                                  icon: Lottie.asset(
                                    'assets/animations/bookmark.json',
                                    height: 30,
                                    width: 30,
                                    controller: _bookmarkController,
                                    repeat: false,
                                    animate: true,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _shareController.forward().then(
                                        (_) => _shareController.reverse());
                                  },
                                  icon: Lottie.asset(
                                    'assets/animations/share.json',
                                    height: 30,
                                    width: 30,
                                    controller: _shareController,
                                    repeat: false,
                                    animate: true,
                                  ),
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
