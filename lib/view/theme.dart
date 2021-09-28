
 import 'package:flutter/material.dart';

ThemeData defaultTheme(){

  return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      fontFamily: 'Roboto',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.deepPurple)
      )
  );

}