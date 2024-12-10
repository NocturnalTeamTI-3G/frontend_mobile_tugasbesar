import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/providers/setting_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  bool _isOldPasswordFilled = false;
  bool _isNewPasswordFilled = false;
  bool _isOldShowPassword = false;
  bool _isNewShowPassword = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _oldPasswordController.addListener(() {
      setState(() {
        _isOldPasswordFilled = _oldPasswordController.text.isNotEmpty;
      });
    });

    _newPasswordController.addListener(() {
      setState(() {
        _isNewPasswordFilled = _newPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    if (settingProvider.isLoading) {
      _oldPasswordController.clear();
      _newPasswordController.clear();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor,
                    AppColors.secondaryColor,
                    AppColors.mainColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 90),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, -2)),
                ],
              ),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Old Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: !_isOldShowPassword,
                      controller: _oldPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Old Password cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Your Old Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: _isOldPasswordFilled
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isOldShowPassword = !_isOldShowPassword;
                                    });
                                  },
                                  icon: Icon(
                                    (_isOldShowPassword)
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                )
                              : null),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'New Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: !_isNewShowPassword,
                      controller: _newPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'New Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Your New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: _isNewPasswordFilled
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNewShowPassword = !_isNewShowPassword;
                                    });
                                  },
                                  icon: Icon(
                                    (_isNewShowPassword)
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                )
                              : null),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await settingProvider.changePassword(
                                _oldPasswordController.text,
                                _newPasswordController.text);
                          }
                        },
                        color: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (settingProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
