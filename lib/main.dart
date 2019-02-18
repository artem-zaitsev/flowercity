import 'package:flower_city/bloc/cart_bloc.dart';
import 'package:flower_city/di/injector.dart';
import 'package:flower_city/ui/flowers_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Injector.cartBloc = CartBloc();
  }

  @override
  void dispose() {
    Injector.cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.indigo,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white
      ),
      home: FlowersScreen(),
    );
  }
}
