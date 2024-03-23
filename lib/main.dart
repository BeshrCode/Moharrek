import 'package:flutter/material.dart';
import 'package:moharrek/auth/login.dart';
import 'package:moharrek/auth/otp_validation.dart';
import 'package:moharrek/auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          fontFamily: "NotoKufiArabic",
          textTheme: TextTheme(
            bodySmall: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 14),
            bodyMedium: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 16),
            bodyLarge: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 18),
            titleSmall: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 22,
                fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 28,
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 36,
                fontWeight: FontWeight.bold),
          )),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Signup(),
      ),
    );
  }
}
