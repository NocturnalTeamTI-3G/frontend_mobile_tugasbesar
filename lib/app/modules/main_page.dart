import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/providers/auth_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/pages/history_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/home/home_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    _selectedIndex = (arg is int) ? arg : 0;
  }

  final List<Widget> _pages = [
    const MainHomePage(),
    const HistoryPage(),
    const NewsPage(),
    const ProductPage(),
  ];

  void onTapChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    void showLoginDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              'Diperlukan Login Untuk Mengakses Fitur Ini',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Kembali', style: TextStyle(fontSize: 16)),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRouters.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                ),
                child: const Text('Login',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_authProvider.isLoggedIn) {
            await Get.toNamed(AppRouters.camera);
          } else {
            showLoginDialog();
          }
        },
        backgroundColor: AppColors.mainColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna shadow
              spreadRadius: 6,
              blurRadius: 10,
              offset: const Offset(0, 3), // Posisi shadow (x,y)
            ),
          ],
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          notchMargin: 6,
          height: 60,
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 15,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 28,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == 0
                                  ? AppColors.mainColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 15,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      onPressed: () {
                        if (_authProvider.isLoggedIn) {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        } else {
                          showLoginDialog();
                        }
                      },
                      // color: _selectedIndex == 1 ? Colors.grey[100] : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: _selectedIndex == 1
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 28,
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == 1
                                  ? AppColors.mainColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 15,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      onPressed: () {
                        if (_authProvider.isLoggedIn) {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        } else {
                          showLoginDialog();
                        }
                      },
                      // color: _selectedIndex == 2 ? Colors.grey[100] : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.newspaper,
                            color: _selectedIndex == 2
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 28,
                          ),
                          Text(
                            "News",
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == 2
                                  ? AppColors.mainColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 15,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                      },
                      // color: _selectedIndex == 3 ? Colors.grey[100] : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category,
                            color: _selectedIndex == 3
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 28,
                          ),
                          Text(
                            "Product",
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == 3
                                  ? AppColors.mainColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
