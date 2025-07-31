import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/app_pages.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "记录你的想法",
          body: "随时随地记录你的创意想法，让灵感不再流失",
          image: Icon(
            Icons.lightbulb_outline,
            size: 100.w,
            color: Colors.orange,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
            ),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.only(top: 50.h),
          ),
        ),
        PageViewModel(
          title: "AI智能分析",
          body: "让AI帮你分析想法，提供专业的建议和执行计划",
          image: Icon(
            Icons.psychology_outlined,
            size: 100.w,
            color: Colors.blue,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
            ),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.only(top: 50.h),
          ),
        ),
        PageViewModel(
          title: "开始你的创意之旅",
          body: "现在就开始记录你的第一个想法吧！",
          image: Icon(
            Icons.rocket_launch_outlined,
            size: 100.w,
            color: Colors.green,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
            ),
            pageColor: Colors.white,
            imagePadding: EdgeInsets.only(top: 50.h),
          ),
        ),
      ],
      onDone: () {
        // 保存首次使用标记
        _markFirstLaunch();
        // 跳转到首页
        Get.offAllNamed(Routes.HOME);
      },
      onSkip: () {
        // 保存首次使用标记
        _markFirstLaunch();
        // 跳转到首页
        Get.offAllNamed(Routes.HOME);
      },
      showSkipButton: true,
      skip: Text(
        "跳过",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey,
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        size: 20.w,
        color: Colors.blue,
      ),
      done: Text(
        "开始",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.w, 10.h),
        color: Colors.grey,
        activeSize: Size(22.w, 10.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    );
  }

  void _markFirstLaunch() {
    // TODO: 保存首次使用标记到本地存储
    // 这里可以后续集成本地存储
  }
} 