import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/utils/router.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordFilled = false;
  bool _isShowPassword = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _isPasswordFilled = _passwordController.text.isNotEmpty;
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
          ),
        ),
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
              child: Form(
                key: _formKey,
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
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                    ),
                    const SizedBox(height: 42),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please fill the username';
                        //   }
                        //   return null;
                        // },
                        controller: _usernameController,
                        style: TextStyle(color: AppColors.mainColor),
                        cursorColor: AppColors.mainColor,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent[700]),
                          hintText: 'Username',
                          hintStyle: TextStyle(color: AppColors.mainColor),
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.mainColor,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColors.mainColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColors.mainColor, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColors.mainColor),
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
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isShowPassword,
                        style: TextStyle(color: AppColors.mainColor),
                        cursorColor: AppColors.mainColor,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: AppColors.mainColor),
                          suffixIcon: _isPasswordFilled
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isShowPassword = !_isShowPassword;
                                    });
                                  },
                                  icon: Icon(
                                    (_isShowPassword)
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
                            borderSide: BorderSide(
                                color: AppColors.mainColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRouters.forgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
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
                              splashColor: AppColors.thirdColor,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Get.offAllNamed(AppRouters.main);
                                  });
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Login",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey[100]),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppRouters.registrasi);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
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
