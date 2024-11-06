import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  bool _isPasswordNewFilled = false;
  bool _isShowPasswordNew = false;
  bool _isPasswordConfFilled = false;
  bool _isShowPasswordConf = false;

  @override
  void initState() {
    super.initState();

    _newPasswordController.addListener(() {
      setState(() {
        _isPasswordNewFilled = _newPasswordController.text.isNotEmpty;
      });
    });

    _newPasswordController.addListener(() {
      setState(() {
        _isPasswordConfFilled = _newPasswordController.text.isNotEmpty;
      });
    });
  }

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
            // padding: EdgeInsets.only(top: 270),
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
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Create New Password',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your new unique password',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextField(
                            controller: _newPasswordController,
                            obscureText: !_isShowPasswordNew,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            decoration: InputDecoration(
                              hintText: 'New Password',
                              hintStyle: TextStyle(color: AppColors.mainColor),
                              suffixIcon: _isPasswordNewFilled
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isShowPasswordNew =
                                              !_isShowPasswordNew;
                                        });
                                      },
                                      icon: Icon(
                                        (_isShowPasswordNew)
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.mainColor,
                                      ),
                                    )
                                  : null,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.mainColor,
                              ),
                              fillColor: Colors.orange[50]!,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextField(
                            controller: _confPasswordController,
                            obscureText: !_isShowPasswordConf,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: AppColors.mainColor),
                              suffixIcon: _isPasswordConfFilled
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isShowPasswordConf =
                                              !_isShowPasswordConf;
                                        });
                                      },
                                      icon: Icon(
                                        (_isShowPasswordConf)
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.mainColor,
                                      ),
                                    )
                                  : null,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.mainColor,
                              ),
                              fillColor: Colors.orange[50]!,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: double.infinity,
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
                                  splashColor: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    Get.to(() => LoginPage(),
                                        transition: Transition.fadeIn);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Reset Password",
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
