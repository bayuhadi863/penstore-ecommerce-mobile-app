import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/screens/auth/register_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PENSTORE',
      home: LoginScreen(),
    );
  }
}