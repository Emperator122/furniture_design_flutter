import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';

class MyText {

  static Text h1(
    String text, {
    Color? color,
    MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
    TextStyle? customStyle,
  }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 30,
      ),
    );
  }

  static Text h2(
      String text, {
        Color? color,
        MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
        TextStyle? customStyle,
      }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 24,
      ),
    );
  }

  static Text h3(
      String text, {
        Color? color,
        MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
        TextStyle? customStyle,
      }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 18,
      ),
    );
  }

  static Text h4(
      String text, {
        Color? color,
        MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
        TextStyle? customStyle,
      }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 16,
      ),
    );
  }

  static Text h5(
      String text, {
        Color? color,
        MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
        TextStyle? customStyle,
      }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 14,
      ),
    );
  }

  static Text h6(
      String text, {
        Color? color,
        MyTextFontFamily fontFamily = MyTextFontFamily.nunitoSans,
        TextStyle? customStyle,
      }) {
    return Text(
      text,
      style: fontFamily.textStyle(
        textStyle: customStyle,
        color: color,
        fontSize: 12,
      ),
    );
  }


  MyText._();
}

enum MyTextFontFamily { nunitoSans, gelasio, merriweather }

extension MyTextFontFamilyExt on MyTextFontFamily {
  TextStyle Function({
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) get textStyle {
    switch (this) {
      case MyTextFontFamily.gelasio:
        return GoogleFonts.gelasio;
      case MyTextFontFamily.merriweather:
        return GoogleFonts.merriweather;
      case MyTextFontFamily.nunitoSans:
        return GoogleFonts.nunitoSans;
    }
  }
}
