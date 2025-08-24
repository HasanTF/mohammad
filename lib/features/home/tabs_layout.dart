import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/features/home/tabs/favorite_tab.dart';
import 'package:beuty_support/features/home/tabs/home_tab.dart';
import 'package:beuty_support/features/home/tabs/offers_tab.dart';
import 'package:beuty_support/features/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class TabsLayout extends StatefulWidget {
  const TabsLayout({super.key});

  @override
  State<TabsLayout> createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    OffersTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabs[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: BottomNavigationBar(
                  backgroundColor: AppColors.primary.withAlpha(150),
                  elevation: 0,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black87,
                  unselectedItemColor: Colors.white,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_offer),
                      label: 'Offers',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
