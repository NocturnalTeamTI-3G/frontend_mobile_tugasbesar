import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/pages/check_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/pages/news_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/pages/history_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/home/home_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckPage(),
              ));
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
                        setState(() {
                          _selectedIndex = 1;
                        });
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
                        setState(() {
                          _selectedIndex = 2;
                        });
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
