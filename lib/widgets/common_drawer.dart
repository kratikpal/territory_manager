import 'package:cheminova/screens/change_password_screen.dart';
import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),Text(
                    'Employee ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const UserAccountsDrawerHeader(
          //   accountName: Text("Name"),
          //   accountEmail: Text("Employee ID"),
          //   // currentAccountPicture: CircleAvatar(
          //   //   backgroundImage: AssetImage(
          //   //       'assets/profile.png'), // Replace with actual user image
          //   // ),
          //   decoration: BoxDecoration(
          //     color: Colors.black87,
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage(),));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
