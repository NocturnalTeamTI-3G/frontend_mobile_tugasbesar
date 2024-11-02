import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_mobile_tugasbesar/views/login/create_new_pw_page.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:get/get.dart';

class OtpVerifPage extends StatefulWidget {
  const OtpVerifPage({Key? key}) : super(key: key);

  @override
  State<OtpVerifPage> createState() => _OtpVerifPageState();
}

class _OtpVerifPageState extends State<OtpVerifPage> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

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
                    'OTP Verification',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Enter the verification code sent to your email',
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: TextField(
                              controller: _controllers[index],
                              cursorColor: AppColors.mainColor,
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                fillColor: Colors.white,
                                filled: true,
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: AppColors.mainColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 4) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index + 1]);
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[index - 1]);
                                }
                              },
                            ),
                          );
                        },
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
                          splashColor: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Get.to(() => CreateNewPasswordPage(),
                                transition: Transition.fadeIn);
                          },
                          child: const Center(
                            child: Text(
                              "Verify",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't received code? ",
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
