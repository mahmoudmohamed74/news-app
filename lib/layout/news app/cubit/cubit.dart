// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:first/layout/news%20app/cubit/states.dart';
import 'package:first/moduels/business/business_screen.dart';
import 'package:first/moduels/science/science_screen.dart';
import 'package:first/moduels/settings/settings_screen.dart';
import 'package:first/moduels/sports/sports_screen.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center_outlined,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports_outlined),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_suggest_outlined),
      label: "Settings",
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
}
