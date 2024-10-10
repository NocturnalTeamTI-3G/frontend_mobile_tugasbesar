import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/pages/login/login_page.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordFilled = false;
  bool _isShowPassword = false;

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
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        // const SizedBox(height: 8),
                        Text(
                          'Create your account',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextField(
                            controller: _usernameController,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(color: AppColors.mainColor),
                              prefixIcon: Icon(
                                Icons.person,
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
                            controller: _passwordController,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            obscureText: !_isShowPassword,
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
                        const SizedBox(height: 45),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: const Center(
                                  child: Text(
                                    "Register",
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
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey[100]),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => LoginPage(),
                                    transition: Transition.fadeIn);
                              },
                              child: const Text(
                                'Login',
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
