import 'package:flutter/material.dart';

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    backgroundColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Colors.purple,
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.blueGrey[900],
          fontFamily: 'Sans',
          fontSize: 25
        )
      )
    ),
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline: TextStyle(
          fontFamily: 'Sans',
          color: Colors.black,
          fontSize: 24),
      body1: TextStyle(
          fontFamily: 'Sans',
          color: Colors.black,
          fontSize: 24),
      body2: TextStyle(
          fontFamily: 'Sans',
          color: Colors.black,
          fontSize: 18),
    ),
  );
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Color(0xff323639),
    accentColor: Colors.blue,
    canvasColor: Colors.transparent,
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 24),
      body1: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 24),
      body2: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 18),
    ),
  );
}

final ThemeData kAmoledTheme = _buildAmoledTheme();

ThemeData _buildAmoledTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: Colors.black,
    accentColor: Colors.white,
    canvasColor: Colors.transparent,
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 24),
      body1: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 24),
      body2: TextStyle(
          fontFamily: 'Sans',
          color: Colors.white,
          fontSize: 18),
    ),
  );
}