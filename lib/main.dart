import 'package:flutter/material.dart';
import 'package:materi_ipa/screen/home.dart';
import 'package:materi_ipa/screen/login_screen.dart';
import 'package:materi_ipa/screen/pdfview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      onGenerateRoute: (initial){
        switch (initial.name) {
          case '/login':
            return MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
                settings: RouteSettings());
          case '/home':
            return MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
                settings: RouteSettings());
          case '/pdf':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = Map<String, dynamic>();
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return Pdfview(arguments['url'], arguments['fileName']);
                },
                settings: RouteSettings());
          default:
            return null;
        }
      },
    );
  }
}
