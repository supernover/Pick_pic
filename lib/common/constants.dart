import 'package:flutter/material.dart';

// color
const yPrimaryColor = Color(0xFF535353);
const yTextLightColor = Color(0xFFACACAC);
const loginColor = Colors.grey;

// padding
const mediumPadding = 16.0;
const smallPadding = 8.0;
const verySmallPadding = 4.0;
const bigPadding = 24.0;
const veryBigPadding = 32.0;

//
const smallSize = 24.0;
const mediumSize = 32.0;
const bigSize = 56.0;

//
const mediumText = 24.0;
const bigMediumText = 48.0;

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  shadowColor: Colors.grey,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  shadowColor: Colors.grey,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
