import 'package:flutter/material.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/news_container.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> filters = [
    'Trending',
    'Technology',
    'Business',
    'Sports',
    'Entertainment',
    'Health',
  ];

  String selectedCategory = 'Trending';

  String _getCategoryFromFilter(String filter) {
    return filter == 'Trending' ? '' : filter.toLowerCase();
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedCategory = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter List
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((filter) {
              final isSelected = selectedCategory == filter;
              return GestureDetector(
                onTap: () => _onFilterSelected(filter),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: Text(
                    filter,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white30,
                        fontFamily: 'Prompt',
                        fontSize: 22,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // News Container
        NewsContainer(category: _getCategoryFromFilter(selectedCategory)),
      ],
    );
  }
}
