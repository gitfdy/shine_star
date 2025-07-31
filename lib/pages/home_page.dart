import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../utils/screen_util.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shine Star'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 跳转到设置页面
            },
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 100.w,
                color: Colors.deepPurple,
              ),
              AdaptiveSpacing(height: 20),
              AdaptiveText(
                '欢迎来到 Shine Star!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              AdaptiveSpacing(height: 30),
              Obx(() => AdaptiveText(
                    '点击次数: ${controller.count.value}',
                    style: TextStyle(fontSize: 18),
                  )),
              AdaptiveSpacing(height: 20),
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  onPressed: controller.increment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: AdaptiveText(
                    '点击我',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              AdaptiveSpacing(height: 20),
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/demo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: AdaptiveText(
                    'UI适配演示',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
