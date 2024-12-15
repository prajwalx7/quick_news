import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/pages/Details%20Page/detail_page.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final List<Color> _colors = const [
    Color(0xffFFE8E5),
    Color(0xffFFF2C5),
    Color(0xffE0F1FF),
    Color(0xffEDE5FF),
    Color(0xffE5FFD3),
  ];
  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles =
        Provider.of<BookmarkProvider>(context).bookmarkedArticles;
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(fontFamily: 'Questrial', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff0C0C0C),
      ),
      body: bookmarkedArticles.isEmpty
          ? const Center(
              child: Text(
                'No bookmarks yet!',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Questrial', color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = bookmarkedArticles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          article: article,
                          backgroundColor: _colors[index % _colors.length],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff393939),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(
                                color: Colors.white), // Text color
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              hintText: "Search News",
                              hintStyle: const TextStyle(color: Colors.white70),
                              prefixIcon: const Icon(Iconsax.search_normal,
                                  color: Colors.white70),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: Key(article['title']),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            Provider.of<BookmarkProvider>(context,
                                    listen: false)
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
                              color: _colors[index % _colors.length],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['title'] ?? "No Title",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Prompt',
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
