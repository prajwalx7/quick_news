import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _bookmarkedArticles = [];

  List<Map<String, dynamic>> get bookmarkedArticles => _bookmarkedArticles;

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedBookmarks = prefs.getString('bookmarks');

    if (savedBookmarks != null) {
      _bookmarkedArticles.clear();
      _bookmarkedArticles
          .addAll(List<Map<String, dynamic>>.from(jsonDecode(savedBookmarks)));
      print(
          "Bookmarks loaded: $_bookmarkedArticles"); 
      notifyListeners();
    }
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodeData = jsonEncode(_bookmarkedArticles);
    await prefs.setString('bookmarks', encodeData);
  }

  void addBookmark(Map<String, dynamic> article) async {
    _bookmarkedArticles.insert(0, article);
    await _saveToPreferences();
    notifyListeners();
  }

  void removeBookmark(Map<String, dynamic> article) async {
    _bookmarkedArticles.removeWhere((bookmarkedArticles) =>
        bookmarkedArticles['title'] == article['title']);
    await _saveToPreferences();
    notifyListeners();
  }
}
