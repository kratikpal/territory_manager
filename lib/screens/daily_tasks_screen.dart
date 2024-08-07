import 'package:cheminova/screens/collect_kyc_screen.dart';
import 'package:cheminova/screens/update_inventory_screen.dart';
import 'package:cheminova/screens/display_sales_screen.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/screens/visit_Dealers_screen.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_background.dart';

class DailyTasksScreen extends StatelessWidget {
  const DailyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/Back_attendance.png'),
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
        title: const Center(
          child: Text(
            'Daily Tasks',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
        ),
      ),
      drawer: const CommonDrawer(),
      body: CommonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildCustomCard(
                        'Visit Dealers/Retailers',
                        '',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VisitDealersScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      _buildCustomCard(
                        'Update Sales Data',
                        '',
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const DisplaySalesScreen(),));
                        },
                      ),
                      const SizedBox(height: 5),
                      _buildCustomCard('Update Inventory Data', '',onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateInventoryScreen(),));
                      },),
                      const SizedBox(height: 5),
                      _buildCustomCard('Collect KYC Documents', '',onTap:() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const CollectKycScreen(),));
                      }, ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCard(String title, String subtitle, {void Function()? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              fontFamily: 'Anek'),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        )
            : null,
        onTap: onTap,
      ),
    );
  }
}
