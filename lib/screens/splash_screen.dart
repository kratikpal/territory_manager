import 'package:cheminova/constants/constant.dart';
import 'package:cheminova/screens/home_screen.dart';
import 'package:cheminova/screens/login_screen.dart';
import 'package:cheminova/services/secure__storage_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _checkLogin() {
    SecureStorageService().read(key: 'user').then((value) {
      if (value != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: const EdgeInsets.only(top: 110, bottom: 50),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset('assets/cheminova_logo.png'),
                      const Text('HELPING YOU GROW',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: robotoFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Image.asset('assets/plant.png'),
                  const Column(
                    children: [
                      Text('Powered By',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: robotoFamily,
                              fontWeight: FontWeight.w500)),
                      Text('codeology.solutions',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: robotoFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ])));
  }
}
