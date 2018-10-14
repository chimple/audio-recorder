import 'package:demo/home.dart';
import 'package:demo/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}
