import 'package:cheminova/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonBackground(
          isFullWidth: true,
          child: Scaffold(
            drawer: const CommonDrawer(),
            backgroundColor: Colors.transparent,
            appBar: CommonAppBar(
              title: const Text('Profile'),
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
            ),
            body: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final profileData = userProvider.user;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0)
                            .copyWith(top: 15, bottom: 30),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: const Color(0xffB4D1E5).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            _buildProfileItem('Name', profileData?.name ?? ''),
                            _buildProfileItem('ID', profileData?.uniqueId ?? ''),
                            _buildProfileItem(
                                'Email ID', profileData?.email ?? ''),
                            _buildProfileItem('Mobile Number',
                                profileData?.mobileNumber ?? ''),
                            _buildProfileItem(
                                'Designation', profileData?.designation ?? ''),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff004791),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
