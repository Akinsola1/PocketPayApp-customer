import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/screens/onboarding/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}
