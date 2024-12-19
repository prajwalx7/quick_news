import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/pages/Details%20Page/detail_page.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
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
    Provider.of<BookmarkProvider>(context, listen: false).loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles =
        Provider.of<BookmarkProvider>(context).bookmarkedArticles;

    final filteredBookmarkedArticles = bookmarkedArticles
        .where((article) =>
            article['title'] != null &&
            article['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff393939),
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => setState(() {
                  _searchQuery = value;
                }),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: "Search News",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
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
          filteredBookmarkedArticles.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 250.0),
                  child: Text(
                    'No bookmarks yet!',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Questrial',
                        color: Colors.white),
                  ),
                )
              : Expanded(
                  child: FadingEdgeScrollView.fromScrollView(
                    gradientFractionOnStart: 0.05,
                    gradientFractionOnEnd: 0.5,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      controller: _scrollController,
                      itemCount: filteredBookmarkedArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredBookmarkedArticles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailPage(
                                  article: article,
                                  backgroundColor:
                                      _colors[index % _colors.length],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article['title'] ?? "No Title",
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Prompt',
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 4,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          article['publishedAt'],
                                          style: const TextStyle(
                                              fontFamily: 'Prompt'),
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
                  ),
                ),
        ],
      ),
    );
  }
}
