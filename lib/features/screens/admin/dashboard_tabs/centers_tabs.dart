import 'package:beuty_support/features/screens/admin/dashboard_tabs/sub_tabs/current_centers.dart';
import 'package:beuty_support/features/screens/admin/dashboard_tabs/sub_tabs/pending_centers.dart';
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
          TabBar(
            tabs: [
              Tab(text: S.of(context).pending),
              Tab(text: S.of(context).currents),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black45,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            dividerHeight: 0,
          ),

          const Expanded(
            child: TabBarView(children: [PendingCenters(), CentersTab()]),
          ),
        ],
      ),
    );
  }
}
