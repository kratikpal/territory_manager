import 'package:cheminova/provider/collect_kyc_provider.dart';
import 'package:cheminova/provider/user_provider.dart';
import 'package:cheminova/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CollectKycProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
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
