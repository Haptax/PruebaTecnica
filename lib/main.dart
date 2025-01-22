import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() {
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      scaffoldBackgroundColor: Color(0xFF212121),
    ),
  ));
}
