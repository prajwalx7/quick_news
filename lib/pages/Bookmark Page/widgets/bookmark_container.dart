import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quick_news/services/bookmark_provider.dart';

Widget bookamrkContainer(
    BuildContext context, Map<String, dynamic> article, int index) {
  final List<Color> colors = [
    const Color(0xffFFE8E5),
    const Color(0xffFFF2C5),
    const Color(0xffE0F1FF),
    const Color(0xffEDE5FF),
    const Color(0xffE5FFD3),
  ];
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Dismissible(
          key: Key(article['title']),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<BookmarkProvider>(context, listen: false)
                .removeBookmark(article);
          },
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? "No Title",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 10.h),
                Text(
                  article['publishedAt'],
                  style: const TextStyle(fontFamily: 'Prompt'),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
