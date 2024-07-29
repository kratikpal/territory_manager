// import 'package:flutter/material.dart';
//
// class SnackBarService {
//   // Private constructor
//   SnackBarService._privateConstructor();
//
//   // Single instance of the class
//   static final SnackBarService _instance =
//       SnackBarService._privateConstructor();
//
//   // Factory constructor to return the same instance every time
//   factory SnackBarService() => _instance;
//
//   // Method to show snackbar
//   void showSnackBar(String message,
//       {Duration duration = const Duration(seconds: 3)}) {
//     final context = _scaffoldMessengerKey.currentContext;
//     if (context != null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(message), duration: duration));
//     }
//   }
// }
