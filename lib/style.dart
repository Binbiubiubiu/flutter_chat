import 'package:flutter/material.dart';

const primary = Color(0xFF57BE6A);
const secondary = Color(0xFFA9EA7C);

const background = Color(0xFFEDEDED);

var appTheme = ThemeData(
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  appBarTheme: AppBarTheme(
    color: background,
    elevation: 1.0,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
