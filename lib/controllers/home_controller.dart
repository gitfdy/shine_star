import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onReady() {
    super.onReady();
    // 页面准备完成后的逻辑
  }

  @override
  void onClose() {
    super.onClose();
    // 清理资源
  }
} 