import 'package:cheminova/notification_service.dart';
import 'package:cheminova/provider/user_provider.dart';
import 'package:cheminova/screens/Visit_Dealers_screen.dart';
import 'package:cheminova/screens/assign_task_dash_board_screen.dart';
import 'package:cheminova/screens/calendar_screen.dart';
import 'package:cheminova/screens/collect_kyc_screen.dart';
import 'package:cheminova/screens/mark_attendence_screen.dart';
import 'package:cheminova/screens/notification_screen.dart';
import 'package:cheminova/screens/products_manual_screen.dart';
import 'package:cheminova/screens/rejected_application_screen.dart';
import 'package:cheminova/screens/select_distributer_screen.dart';
import 'package:cheminova/screens/display_sales_screen.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserProfile();
    });
    notificationServices.requestNotificationPermission();

    notificationServices.getDeviceToken().then((value) {
      print('Device Token: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              // CircleAvatar(
              //   backgroundImage: AssetImage(
              //       'assets/profile.png'), // Replace with actual user image
              // ),
              // const SizedBox(width: 10),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        userProvider.user?.name ?? 'User Name',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const CommonDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildCustomCard(
                        'Mark Attendance',
                        'Mark Attendance / On Leave',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MarkAttendanceScreen(),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _buildCustomCard('Assign Tasks', 'Dashboard', onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AssignTaskDashBoardScreen(),
                            ));
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCustomCard('Collect \nKYC Data',
                                'Scan and upload KYC Documents', onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CollectKycScreen(),
                                  ));
                            }),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: _buildCustomCard('Update Inventory Data',
                                'Quickly Inventory Data', onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectDistributerScreen(
                                      task: "Update Inventory",
                                    ),
                                  ));
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCustomCard(
                              'Visit RD/PD\n\n',
                              '',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VisitDealersScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: _buildCustomCard('Update\nSales Data\n', '',
                                onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectDistributerScreen(
                                    task: "Update Sales",
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCustomCard('Rejected Applications',
                                'Re-upload Rejected Documents', onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RejectedApplicationScreen(),
                                  ));
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCustomCard(
                                'Notifications', 'Tasks & Alerts\n\n',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen(),
                                  ));
                            }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: _buildCustomCard(
                              'Calendar',
                              ' Upcoming Appointments & Deadlines',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CalendarScreen(),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCustomCard(
                                'Products Manual', 'details of products',
                                onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductsManualScreen(),
                                  ));
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCard(String title, String subtitle,
      {void Function()? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        // trailing: Image.asset('assets/forward_icon.png'),
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
