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
    _bookmarkedArticles.addAll(List<Map<String, dynamic>>.from(jsonDecode(savedBookmarks)));
    print("Bookmarks loaded from SharedPreferences: $_bookmarkedArticles"); // Add this for debugging
    notifyListeners();
  }
}


  Future<void> _saveToPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final String encodeData = jsonEncode(_bookmarkedArticles);
  print("Saving bookmarks to preferences: $encodeData"); // Add this line for debugging
  await prefs.setString('bookmarks', encodeData);
}


  void addBookmark(Map<String, dynamic> article) async {
    print("Adding bookmark: $article");
    _bookmarkedArticles.add(article);
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
