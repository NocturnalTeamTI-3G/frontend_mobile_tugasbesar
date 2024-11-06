import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/register_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: controller,
              children: [
                _buildPage(
                  context,
                  'assets/images/intro/face-check.png',
                  'Acne Detection',
                  'Deteksi jerawat pada wajahmu dengan cepat dan akurat',
                ),
                _buildPage(
                  context,
                  'assets/images/intro/solution.png',
                  'Solusi Penanganan',
                  'Solusi penanganan sesuai dengan kondisi kulit wajahmu',
                ),
                _buildPage(
                  context,
                  'assets/images/intro/product.png',
                  'Rekomendasi Produk',
                  'Rekomendasi produk perawatan sesuai dengan kondisi wajah',
                ),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.75),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  dotWidth: 11,
                  dotHeight: 11,
                  activeDotColor: AppColors.mainColor,
                  dotColor: Colors.grey[400]!,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SkinAssist',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => const RegisterPage(),
                                    transition: Transition.rightToLeft);
                              },
                              child: Text(
                                'Privasi',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRouters.login);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainColor,
                                AppColors.secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: AppColors.thirdColor,
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Get.to(() => const LoginPage(),
                                  transition: Transition.rightToLeft);
                            },
                            child: const Center(
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildPage(
    BuildContext context, String imagePath, String title, String description) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 270,
            maxWidth: 330,
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 50),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 30,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
