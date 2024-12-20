import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/pages/Bookmark%20Page/widgets/animated_list.dart';
import 'package:quick_news/services/bookmark_provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
              : CustomAnimatedList()
        ],
      ),
    );
  }
}
