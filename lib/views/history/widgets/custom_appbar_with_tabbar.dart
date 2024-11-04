import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';

class CustomAppbarWithTabbar extends StatelessWidget {
  const CustomAppbarWithTabbar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Result',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              // Add functionality for leading button tap here
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 53, 40, 40),
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  width: 40, // Ensure fixed width and height for the image
                  height: 40,
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    // Add functionality for notifications button tap here
                  },
                  icon: const Icon(
                    Icons.notifications_rounded,
                    size: 28,
                  ),
                ),
                Positioned(
                  right: 13,
                  top: 12,
                  child: Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
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
