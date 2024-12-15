import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _bookmarkedArticles = [];

  List<Map<String, dynamic>> get bookmarkedArticles => _bookmarkedArticles;

  void addBookmark(Map<String, dynamic> article) {
    _bookmarkedArticles.add(article);
    notifyListeners();
  }

  void removeBookmark(Map<String, dynamic> article) {
    _bookmarkedArticles.remove(article);
    notifyListeners();
  }
}
