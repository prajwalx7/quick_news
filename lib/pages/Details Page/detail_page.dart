import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> article;
  final Color backgroundColor;
  DetailPage({super.key, required this.article, required this.backgroundColor});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white60, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Iconsax.arrow_left)),
                ),
                const SizedBox(height: 30),
                Text(
                  article['title'] ?? "Not available",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  article['publishedAt'],
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                AuthorWidget(
                  author: article['author'] ?? "Not available",
                ),
                const SizedBox(height: 30),
                Text(
                  article['description'] ?? "not available.",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
                article['urlToImage'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          article['urlToImage'],
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () => _launchUrl(article['url']),
                    child: const Text(
                      'Read Full Article',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
