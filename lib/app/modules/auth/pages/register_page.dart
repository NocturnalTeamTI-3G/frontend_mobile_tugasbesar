import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/providers/auth_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

  final _formKey = GlobalKey<FormState>();

  final List<String> optionList = ['Laki-laki', 'Perempuan'];

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
    String selectedValue = optionList[0];
    final _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 150,
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
                ),
                Container(
                  margin: const EdgeInsets.only(top: 110),
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
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 32,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextFormField(
                            controller: _usernameController,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the username';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
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
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
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
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: TextFormField(
                            controller: _passwordController,
                            style: TextStyle(color: AppColors.mainColor),
                            cursorColor: AppColors.mainColor,
                            obscureText: !_isShowPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
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
                        const SizedBox(height: 16),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: DropdownButtonFormField(
                              value: selectedValue,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.wc,
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
                              ),
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: AppColors.mainColor),
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: optionList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        const SizedBox(height: 45),
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
                                  splashColor: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _authProvider.register(
                                        _emailController.text,
                                        _passwordController.text,
                                        _usernameController.text,
                                        selectedValue,
                                      );
                                    }
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => LoginPage(),
                                    transition: Transition.fadeIn);
                              },
                              child: const Text(
                                'Login',
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
                          child: MaterialButton(
                            onPressed: () {
                              _authProvider.signUpWithGoogle();
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
