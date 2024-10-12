import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/pages/check/check_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/fitplan/fitplan_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/history/history_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/home/home_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/profile/profile_page.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainHomePage(),
    const HistoryPage(),
    const FitplanPage(),
    const ProfilePage(),
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
          Icons.camera,
          color: Colors.white,
          size: 38,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        // padding: const EdgeInsets.symmetric(horizontal: 5),
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 25,
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      // color: _selectedIndex == 0 ? Colors.grey[100] : null,
                
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 30,
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
                      minWidth: 25,
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
                            Icons.history_edu,
                            color: _selectedIndex == 1
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            "Report",
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
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minWidth: 25,
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
                            Icons.info,
                            color: _selectedIndex == 2
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            "Info",
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
                      minWidth: 25,
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
                            Icons.settings,
                            color: _selectedIndex == 3
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            "Setting",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
