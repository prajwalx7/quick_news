import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_news/pages/Home%20Page/Widgets/author_widget.dart';
import 'package:quick_news/widgets/icons_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> article;
  final Color backgroundColor;
  const DetailPage(
      {super.key, required this.article, required this.backgroundColor});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animations = List.generate(
      8,
      (index) => CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          (index / 8) * 0.5, // Starts from 0 to 0.5 evenly distributed
          ((index + 1) / 8) * 0.5 +
              0.5, // Ends from 0.5 to 1.0 evenly distributed
          curve: Curves.easeOut,
        ),
      ),
    );

    // Start animation after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildAnimatedChild(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              0, 100 * (1 - animation.value)), // Move from 100 pixels below
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAnimatedChild(
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  _animations[0],
                ),
                SizedBox(height: 30.h),
                buildAnimatedChild(
                  Text(
                    widget.article['title'] ?? "Not available",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Prompt',
                      fontSize: 32.sp,
                    ),
                  ),
                  _animations[1],
                ),
                SizedBox(height: 10.h),
                buildAnimatedChild(
                  Text(
                    widget.article['publishedAt'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Prompt',
                    ),
                  ),
                  _animations[2],
                ),
                SizedBox(height: 20.h),
                buildAnimatedChild(
                  AuthorWidget(
                    author: widget.article['author'] ?? "Not available",
                  ),
                  _animations[3],
                ),
                SizedBox(height: 30.h),
                buildAnimatedChild(
                  Text(
                    widget.article['description'] ?? "not available.",
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontFamily: 'Questrial',
                    ),
                  ),
                  _animations[4],
                ),
                buildAnimatedChild(
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () => _launchUrl(widget.article['url']),
                      child: Text(
                        'Read Full Article',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.blue,
                          fontFamily: 'Questrial',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  _animations[5],
                ),
                buildAnimatedChild(
                  widget.article['urlToImage'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            widget.article['urlToImage'],
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text(
                          'No image available',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'prompt',
                          ),
                        ),
                  _animations[6],
                ),
                buildAnimatedChild(
                  Padding(
                    padding:  EdgeInsets.only(right: 16.0.w, top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconsWidget(article: widget.article),
                      ],
                    ),
                  ),
                  _animations[7],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
