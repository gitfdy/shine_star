import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilHelper {
  // 设计稿尺寸 (建议使用iPhone 12 Pro的尺寸作为基准)
  static const double designWidth = 390.0;
  static const double designHeight = 844.0;

  // 初始化屏幕适配
  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(designWidth, designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  // 获取屏幕宽度
  static double getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  // 获取屏幕高度
  static double getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  // 获取状态栏高度
  static double getStatusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }

  // 获取底部安全区域高度
  static double getBottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }

  // 获取屏幕像素密度
  static double getPixelRatio() {
    return ScreenUtil().pixelRatio ?? 1.0;
  }

  // 获取屏幕方向
  static Orientation getOrientation() {
    return ScreenUtil().orientation;
  }

  // 判断是否为横屏
  static bool isLandscape() {
    return ScreenUtil().orientation == Orientation.landscape;
  }

  // 判断是否为竖屏
  static bool isPortrait() {
    return ScreenUtil().orientation == Orientation.portrait;
  }
}

// 扩展方法，方便使用
extension ScreenUtilExtension on num {
  // 宽度适配
  double get w => ScreenUtil().setWidth(this);
  
  // 高度适配
  double get h => ScreenUtil().setHeight(this);
  
  // 字体大小适配
  double get sp => ScreenUtil().setSp(this);
  
  // 半径适配
  double get r => ScreenUtil().radius(this);
  
  // 屏幕宽度百分比
  double get sw => ScreenUtil().screenWidth * this;
  
  // 屏幕高度百分比
  double get sh => ScreenUtil().screenHeight * this;
} 