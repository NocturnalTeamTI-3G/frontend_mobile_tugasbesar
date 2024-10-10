import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/pages/login/otp_verif_page.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orangeAccent,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainColor, width: 3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.mainColor,
                size: 23,
              ),
            )),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.orangeAccent[400]
              gradient: LinearGradient(
                colors: [
                  AppColors.mainColor,
                  AppColors.mainColor,
                  AppColors.secondaryColor,
                  AppColors.mainColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipPath(
                    clipper: BottomWaveClipper(),
                    child: Image.asset(
                      'assets/images/login.jpg',
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Please enter your email linked with your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: AppColors.mainColor),
                      cursorColor: AppColors.mainColor,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColors.mainColor),
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.mainColor,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: AppColors.mainColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: AppColors.mainColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 280,
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
                          splashColor: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Get.to(() => OtpVerifPage(),
                                transition: Transition.fadeIn);
                          },
                          child: const Center(
                            child: Text(
                              "Send Code",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 100); // Start from the bottom left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 100); // Create wave
    path.lineTo(size.width, 0.0); // Top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
