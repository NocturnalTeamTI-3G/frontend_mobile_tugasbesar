import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/pages/setting_page.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.white,
            leading: Container(
              height: double.infinity,
              alignment: Alignment.center,
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
            leadingWidth: 130,
            actions: [
              GestureDetector(
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
            ],
            toolbarHeight: 60,
          ),
        ],
      ),
    );
  }
}
