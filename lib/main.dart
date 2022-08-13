// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, unnecessary_null_comparison

import 'package:first/layout/news%20app/cubit/cubit.dart';
import 'package:first/layout/news%20app/news_layout.dart';
import 'package:first/layout/shop%20app/cubit/cubit.dart';
import 'package:first/layout/shop%20app/shop_layout.dart';
import 'package:first/layout/todo%20app/todo_layout.dart';
import 'package:first/moduels/basics_app/login/loginscreen.dart';
// import 'package:first/moduels/basics_app/login/loginscreen.dart';
import 'package:first/moduels/shop_app/login/shop_login.dart';
import 'package:first/moduels/shop_app/on_boarding/on_boarding_screen.dart';

import 'package:first/shared/bloc_observer.dart';
import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:first/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'shared/components/constants.dart';

void main() {
  //put run app in runzoned
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // used for async & await 7uegy b3dha
    DioHelper.init();
    await CacheHelper.init();
    bool? isDark = CacheHelper.getData(key: "isDark");
    Widget? widget;
    bool? onBoarding = CacheHelper.getData(key: "onBoarding");
    print(token.toString());
    if (onBoarding != null) {
      if (token != null) {
        widget = ShopLayout();
      } else {
        widget = ShopLoginScreen();
      }
    } else {
      widget = OnBoardingScreen();
    }
    runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme, //******************Light Theme**********

            // darkTheme: lightTheme, //******************Dark Theme**********
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
