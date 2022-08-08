// ignore_for_file: unused_import, prefer_const_constructors, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:first/layout/news%20app/cubit/cubit.dart';
import 'package:first/layout/news%20app/news_layout.dart';
import 'package:first/layout/todo%20app/todo_layout.dart';
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

void main() {
  //put run app in runzoned
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // used for async & await 7uegy b3dha
    DioHelper.init();
    await CacheHelper.init();
    bool? isDark = CacheHelper.getBoolean(key: "isDark");
    runApp(MyApp(isDark));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

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
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
