import 'package:flutter/material.dart';
import 'package:moharrek/pages/add_car_page.dart';
import 'package:moharrek/pages/auth/otp_validation_page.dart';
import 'package:moharrek/pages/auth/register_page.dart';
import 'package:moharrek/pages/auth/username_page.dart';
import 'package:moharrek/bottom_nav_bar.dart';
import 'package:moharrek/pages/car_details_page.dart';
import 'package:moharrek/pages/home_page.dart';
import 'package:moharrek/pages/my_car.dart';
import 'package:moharrek/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          fontFamily: "NotoKufiArabic",
          textTheme: TextTheme(
            bodySmall: TextStyle(
              fontFamily: "NotoKufiArabic",
              fontSize: 14,
            ),
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
        child: BottomNavBar(),
      ),
    );
  }
}
