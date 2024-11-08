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

    _confPasswordController.addListener(() {
      setState(() {
        _isPasswordConfFilled = _confPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              border: Border.all(color: AppColors.white, width: 3),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
              size: 23,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 290,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor,
                    AppColors.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'SkinAssist App',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 250),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                                    _isShowPasswordNew = !_isShowPasswordNew;
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
                                    _isShowPasswordConf = !_isShowPasswordConf;
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
    );
  }
}
