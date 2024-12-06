import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final List<String> filters = [
    'Trending',
    'Technology',
    'Business',
    'Sports',
    'Entertainment',
    'Health',
    'Education'
  ];

  String selectedfilter = 'Trending';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedfilter == filter;
          return GestureDetector(
            onTap: () {
              setState(() {
                if (filter == 'Trending') {
                  selectedfilter = 'Trending';
                } else {
                  selectedfilter = filter;
                }
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white30,
                      fontSize: 22,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
