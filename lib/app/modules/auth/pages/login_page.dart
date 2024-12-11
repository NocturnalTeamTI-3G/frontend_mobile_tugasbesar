import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/providers/auth_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    final _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 270,
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
                  margin: const EdgeInsets.only(top: 230),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 32,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the email';
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            cursorErrorColor: AppColors.mainColor,
                            decoration: InputDecoration(
                              errorStyle:
                                  TextStyle(color: Colors.redAccent[700]),
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
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
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
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isShowPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            cursorErrorColor: AppColors.mainColor,
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
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
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
                                  // Get.toNamed(AppRouters.forgotPassword);
                                  Get.snackbar(
                                    'Fitur Sedang Dalam Pengembangan',
                                    'Silakan coba lagi nanti.',
                                    backgroundColor: Colors.blue,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
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
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _authProvider.login(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
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
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRouters.registrasi);
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey[400],
                          thickness: 1,
                          indent: 60,
                          endIndent: 60,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          // margin: const EdgeInsets.only(bottom: 20),
                          child: MaterialButton(
                            onPressed: () {
                              _authProvider.signInWithGoogle();
                            },
                            color: Colors.white,
                            elevation: 2,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icon/google.png',
                                  height: 27,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_authProvider.isLoading)
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
