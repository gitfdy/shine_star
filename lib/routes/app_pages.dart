import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../pages/home_page.dart';
import '../pages/splash_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/demo_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: Routes.DEMO,
      page: () => const DemoPage(),
    ),
  ];
}
