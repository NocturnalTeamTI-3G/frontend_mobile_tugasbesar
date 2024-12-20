import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/providers/auth_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/pages/setting_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/providers/setting_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final String url = '${Api.baseUrl}/api/image/user/';

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
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
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
              _authProvider.isLoggedIn
                  ? Consumer<SettingProvider>(
                      builder: (context, settingProvider, child) {
                        if (settingProvider.user == null) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => const SettingPage());
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'assets/images/default_profile.png'),
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const SettingPage());
                          },
                          child: (settingProvider.user?.profileImg == 'null')
                              ? const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/default_profile.png'),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    settingProvider.user!.profileImg
                                            .startsWith('http')
                                        ? settingProvider.user!.profileImg
                                        : '$url${settingProvider.user!.profileImg}',
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/default_profile.png',
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    ),
                                    loadingBuilder: (context, child,
                                            loadingProgress) =>
                                        loadingProgress == null
                                            ? child
                                            : const CircularProgressIndicator(),
                                  ),
                                ),
                        );
                      },
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
