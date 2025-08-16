import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/features/admin/dashboard_tabs/sub_tabs/current_centers.dart';
import 'package:beuty_support/features/admin/dashboard_tabs/sub_tabs/pending_centers.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:flutter/material.dart';

class CentersTabs extends StatelessWidget {
  const CentersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Custom TabBar at the top (no AppBar)
          TabBar(
            tabs: [
              Tab(text: S.of(context).pending),
              Tab(text: S.of(context).currentPassword),
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

          const Expanded(
            child: TabBarView(children: [PendingCenters(), CentersTab()]),
          ),
        ],
      ),
    );
  }
}
