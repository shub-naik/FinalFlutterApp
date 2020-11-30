import 'NewsInfo.dart';
import 'SplashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/NewsInfo': (context) => NewsInfo(),
      },
    ));
