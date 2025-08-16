import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/features/home/tabs/home_tab.dart';
import 'package:beuty_support/features/home/tabs/news_tab.dart';
import 'package:beuty_support/features/home/tabs/profile_tab.dart';
import 'package:beuty_support/features/home/tabs/search_tab.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    NewsTab(),
    SearchTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: AppColors.cWhite,
        elevation: 0,
        iconSize: 28,
        unselectedItemColor: AppColors.cLightGrey,
        selectedItemColor: AppColors.cPrimary,
        unselectedLabelStyle: TextStyle(fontSize: 10),
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
