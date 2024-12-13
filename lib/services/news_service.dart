import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsService {
  static const String _apiKey = 'f2467f84786b4690987ba41e4e389215';
  static const String _baseUrl = 'https://newsapi.org/v2';

  static Future<List<dynamic>> fetchNews(String category) async {
    final url = Uri.parse(
        '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data['articles'];

      final DateFormat formatter = DateFormat('MMM dd, yyyy, h:mm a');

      articles = articles.where((article) {
        return article['title'] != null &&
            article['author'] != null &&
            article['description'] != null &&
            article['title'] != 'Removed';
      }).map((article) {
        if (article['publishedAt'] != null) {
          final DateTime publishedAt = DateTime.parse(article['publishedAt']);
          article['publishedAt'] = formatter.format(publishedAt);
        }

        article['content'] ??= "No content available";
        article['urlToImage'] ??= "https://via.placeholder.com/150";

        return article;
      }).toList();

      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
