// Global key for the ScaffoldMessenger
import 'package:flutter/material.dart';

const String robotoFamily = 'Roboto';

final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
    _scaffoldMessengerKey;
