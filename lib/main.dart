// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:first/layout/news%20app/news_layout.dart';
import 'package:first/layout/todo%20app/todo_layout.dart';
import 'package:first/moduels/counter/Counter_Screen.dart';
import 'package:first/moduels/bmi_result/bmi_result_screen.dart';
import 'package:first/moduels/bmi/bmi_screen.dart';
import 'package:first/moduels/messenger/messenger_screen.dart';
import 'package:first/moduels/home/home_screen.dart';
import 'package:first/moduels/login/loginscreen.dart';
import 'package:first/moduels/users/users_screen.dart';
import 'package:first/shared/bloc_observer.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //put run app in runzoned
  BlocOverrides.runZoned(() {
    DioHelper.init();
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.amber[600],
          ), // 3shan t3adel f appbar & ****statusbar***
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backwardsCompatibility: false, //statusbar
              systemOverlayStyle: SystemUiOverlayStyle(
                //statusbar
                statusBarColor: Colors.white, //statusbar
                statusBarIconBrightness: Brightness.dark, //statusbar
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.amber[600],
            elevation: 20,
            type: BottomNavigationBarType.fixed,
          )),
      home: NewsLayout(),
    );
  }
}
