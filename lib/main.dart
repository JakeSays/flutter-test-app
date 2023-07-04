import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

import 'package:flutter/material.dart';

import 'TestUiView.dart';

void main()
{
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;


    runApp(TestUiApp());
}

class TestUiApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => TestUiView(),
      }
    );
  }
}
