import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../utils/screen_util.dart';
import '../widgets/responsive_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    // 3秒后移除启动画面并跳转
    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
      // TODO: 检查是否首次使用，如果是则跳转到引导页，否则跳转到首页
      // 暂时直接跳转到引导页
      Get.offAllNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: ResponsiveContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 100.w,
                color: Colors.white,
              ),
              AdaptiveSpacing(height: 20),
              AdaptiveText(
                'Shine Star',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              AdaptiveSpacing(height: 20),
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
