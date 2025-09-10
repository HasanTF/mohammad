import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/features/screens/home/favorite_tab.dart';
import 'package:beuty_support/features/screens/home/home_tab.dart';
import 'package:beuty_support/features/screens/home/offers_tab.dart';
import 'package:beuty_support/features/screens/home/profile_tab.dart';
import 'package:beuty_support/generated/l10n.dart';
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
                  backgroundColor: AppColors.secondaryDark.withAlpha(255),
                  elevation: 0,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.white,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: S.of(context).home,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_offer),
                      label: S.of(context).offers,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: S.of(context).favorites,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: S.of(context).profile,
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
