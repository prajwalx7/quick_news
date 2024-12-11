import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = 'f2467f84786b4690987ba41e4e389215';
  static const String _baseUrl = 'https://newsapi.org/v2';

  static Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse(
        '$_baseUrl/top-headlines?country=us&category=technology&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data['articles'];

      articles = articles.where((article) {
        return article['title'] != null &&
            article['author'] != null &&
            article['description'] != null &&
            article['title'] != 'Removed';
      }).toList();

      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
