import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/pages/setting_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';

class CustomAppbarWithTabbar extends StatelessWidget {
  const CustomAppbarWithTabbar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        leading: Container(
          height: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20),
          child: const Row(
            children: [
              Icon(
                Icons.stacked_line_chart,
                color: Colors.deepPurple,
                size: 30,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'SkinAssist',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 150,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const SettingPage());
              },
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 60,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.mainColor,
          labelColor: AppColors.mainColor,
          dividerHeight: 0,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Success'),
            Tab(text: 'Fail'),
          ],
        ),
      ),
    );
  }
}
