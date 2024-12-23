import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.0.w),
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xff393939),
            borderRadius: BorderRadius.circular(42.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildIcon('assets/icons/home.svg', 0, widget.currentIndex),
              buildIcon(
                  'assets/icons/bookmark_outlined.svg', 1, widget.currentIndex),
              buildIcon('assets/icons/user.svg', 2, widget.currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon(String svgPath, int index, int currentIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.0.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: index == currentIndex
              ? const Color(0xffffffff)
              : const Color(0xff393939),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () => widget.onTap(index),
          child: SvgPicture.asset(
            svgPath,
            colorFilter: ColorFilter.mode(
                index == currentIndex ? Colors.black : Colors.white,
                BlendMode.srcIn),
            height: 25.h,
            width: 25.w,
          ),
        ),
      ),
    );
  }
}
