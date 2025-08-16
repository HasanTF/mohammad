import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/features/admin/dashboard_tabs/centers_tabs.dart';
import 'package:beuty_support/features/admin/dashboard_tabs/reviews_tab.dart';
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
              S.of(context).adminDashboard,
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: S.of(context).reviews),
                Tab(text: S.of(context).centers),
              ],
              labelColor: AppColors.cPrimary,
              unselectedLabelColor: AppColors.cPrimary,
              labelStyle: TextStyle(
                fontSize: Sizes.small,
                fontWeight: FontWeight.w900,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: Sizes.small * 0.75,
                fontWeight: FontWeight.normal,
              ),
              indicatorColor: AppColors.cPrimary,
              indicatorWeight: 2,
            ),
          ),
          body: const TabBarView(children: [ReviewsTab(), CentersTabs()]),
        ),
      ),
    );
  }
}
