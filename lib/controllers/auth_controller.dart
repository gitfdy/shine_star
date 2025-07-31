import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoggedIn = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    // 检查登录状态
    isLoading.value = true;
    // 模拟网络请求
    Future.delayed(const Duration(seconds: 2), () {
      isLoggedIn.value = false; // 这里可以根据实际逻辑判断
      isLoading.value = false;
    });
  }

  void login(String username, String password) {
    isLoading.value = true;
    // 模拟登录请求
    Future.delayed(const Duration(seconds: 2), () {
      isLoggedIn.value = true;
      isLoading.value = false;
      Get.offAllNamed('/home');
    });
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
} 