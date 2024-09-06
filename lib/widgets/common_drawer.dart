import 'package:cheminova/provider/user_provider.dart';
import 'package:cheminova/screens/change_password_screen.dart';
import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/screens/login_screen.dart';
import 'package:cheminova/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userProvider.user != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.user!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          userProvider.user!.uniqueId,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text(
                      'No User Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ProfileScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<UserProvider>(context, listen: false)
                    .clearUserProfile();
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
