import 'package:arithmetic_app/features/home/home_page.dart';
import 'package:flutter/material.dart';

import 'features/date_arthmetic/date_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
       "home-page" : (context)=>HomePage(),
        "date-page": (context)=>DateArthmeticPage()
      },
      initialRoute:  "home-page",
    );
  }
}