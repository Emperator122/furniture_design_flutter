import 'package:flutter/material.dart';
import 'package:furniture/registration/boarding_page.dart';
import 'package:furniture/ui/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ApplicationColors.white,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: ApplicationColors.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: ApplicationColors.white,
            titleTextStyle: TextStyle(color: ApplicationColors.black),
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: const BoardingPage(),
    );
  }
}
