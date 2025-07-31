import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/screen_util.dart';
import '../widgets/responsive_widget.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AdaptiveText('UI适配演示'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 屏幕信息展示
              _buildScreenInfo(),
              AdaptiveSpacing(height: 30),
              
              // 响应式网格
              _buildResponsiveGrid(),
              AdaptiveSpacing(height: 30),
              
              // 自适应卡片
              _buildAdaptiveCards(),
              AdaptiveSpacing(height: 30),
              
              // 不同尺寸的按钮
              _buildAdaptiveButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdaptiveText(
              '屏幕信息',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            AdaptiveSpacing(height: 16),
            _buildInfoRow('屏幕宽度', '${ScreenUtilHelper.getScreenWidth().toStringAsFixed(1)}px'),
            _buildInfoRow('屏幕高度', '${ScreenUtilHelper.getScreenHeight().toStringAsFixed(1)}px'),
            _buildInfoRow('状态栏高度', '${ScreenUtilHelper.getStatusBarHeight().toStringAsFixed(1)}px'),
            _buildInfoRow('像素密度', '${ScreenUtilHelper.getPixelRatio().toStringAsFixed(2)}'),
            _buildInfoRow('屏幕方向', ScreenUtilHelper.isPortrait() ? '竖屏' : '横屏'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdaptiveText(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          AdaptiveText(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          '响应式网格',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        AdaptiveSpacing(height: 16),
        ResponsiveWidget(
          mobile: _buildGrid(2),
          tablet: _buildGrid(3),
          desktop: _buildGrid(4),
        ),
      ],
    );
  }

  Widget _buildGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.8),
                  Colors.deepPurple.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 32.w,
                    color: Colors.white,
                  ),
                  AdaptiveSpacing(height: 8),
                  AdaptiveText(
                    '项目 ${index + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdaptiveCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          '自适应卡片',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        AdaptiveSpacing(height: 16),
        ResponsiveWidget(
          mobile: _buildCardsColumn(),
          tablet: _buildCardsRow(),
          desktop: _buildCardsRow(),
        ),
      ],
    );
  }

  Widget _buildCardsColumn() {
    return Column(
      children: [
        _buildCard('小屏幕布局', '在手机上显示为垂直排列'),
        AdaptiveSpacing(height: 12),
        _buildCard('响应式设计', '自动适配不同屏幕尺寸'),
      ],
    );
  }

  Widget _buildCardsRow() {
    return Row(
      children: [
        Expanded(child: _buildCard('大屏幕布局', '在平板和桌面显示为水平排列')),
        AdaptiveSpacing(width: 12),
        Expanded(child: _buildCard('响应式设计', '自动适配不同屏幕尺寸')),
      ],
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdaptiveText(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            AdaptiveSpacing(height: 8),
            AdaptiveText(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdaptiveButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          '自适应按钮',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        AdaptiveSpacing(height: 16),
        ResponsiveWidget(
          mobile: _buildButtonsColumn(),
          tablet: _buildButtonsRow(),
          desktop: _buildButtonsRow(),
        ),
      ],
    );
  }

  Widget _buildButtonsColumn() {
    return Column(
      children: [
        _buildButton('小按钮', 120.w, 40.h, 12.sp),
        AdaptiveSpacing(height: 12),
        _buildButton('中按钮', 160.w, 45.h, 14.sp),
        AdaptiveSpacing(height: 12),
        _buildButton('大按钮', 200.w, 50.h, 16.sp),
      ],
    );
  }

  Widget _buildButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('小', 100.w, 40.h, 12.sp),
        _buildButton('中', 120.w, 45.h, 14.sp),
        _buildButton('大', 140.w, 50.h, 16.sp),
      ],
    );
  }

  Widget _buildButton(String text, double width, double height, double fontSize) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            '按钮点击',
            '你点击了 $text',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.deepPurple,
            colorText: Colors.white,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: AdaptiveText(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
} 