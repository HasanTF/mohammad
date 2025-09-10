import 'package:beuty_support/features/screens/admin/dashboard_tabs/centers_tabs.dart';
import 'package:beuty_support/features/screens/admin/dashboard_tabs/reviews_tab.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).adminpanel,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: S.of(context).reviews),
                Tab(text: S.of(context).clinics),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black45,
              labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              unselectedLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              dividerHeight: 0,
            ),
          ),
          body: const TabBarView(children: [ReviewsTab(), CentersTabs()]),
        ),
      ),
    );
  }
}
