import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:cheminova/screens/Attendance_success.dart';
import 'package:cheminova/screens/forgot_password_screen.dart';
import 'package:cheminova/screens/login_screen.dart';
import 'package:cheminova/screens/mark_attendence_screen.dart';
import 'package:cheminova/screens/on_leave_screen.dart';
import 'package:cheminova/screens/splash_screen.dart';
import 'package:cheminova/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CollectKycProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // scaffoldMessengerKey: SnackBarService().scaffoldMessengerKey,
        title: 'cheminova',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const SplashScreen());
  }
}
