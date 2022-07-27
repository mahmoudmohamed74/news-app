// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors

import 'package:first/layout/news%20app/cubit/cubit.dart';
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
import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // used for async & await 7uegy b3dha

  //put run app in runzoned
  BlocOverrides.runZoned(() async {
    DioHelper.init();
    await CacheHelper.init();
    bool isDark = CacheHelper.getBoolean(key: "isDark");
    runApp(MyApp(isDark: isDark));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark!,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: //******************Light Theme*******************
                ThemeData(
              primarySwatch: Colors.amber,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.amber[600],
              ), // 3shan t3adel f appbar & ****statusbar***
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20,
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
                unselectedItemColor: Colors.grey,
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#121212")),
              ),
            ),

            //******************Dark Theme*******************
            darkTheme: ThemeData(
              primarySwatch: Colors.amber,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.amber[600],
              ), // 3shan t3adel f appbar & ****statusbar***
              scaffoldBackgroundColor: HexColor("#121212"),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  backwardsCompatibility: false, //statusbar
                  systemOverlayStyle: SystemUiOverlayStyle(
                    //statusbar
                    statusBarColor: HexColor("#121212"), //statusbar
                    statusBarIconBrightness: Brightness.light, //statusbar
                  ),
                  backgroundColor: HexColor("#121212"),
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.amber[600],
                unselectedItemColor: Colors.grey,
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor("#121212"),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: HexColor("#F8F0E3"),
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
