 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/news%20app/states.dart';
import 'package:newsapp/news%20app/business.dart';
import 'package:newsapp/news%20app/scince.dart';
import 'package:newsapp/news%20app/sports.dart';
import 'package:newsapp/network/remote/dio.helper.dart';

class NewsCubit extends Cubit <NewsStates> {
  NewsCubit() : super (NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List <BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',


    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',


    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',


    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',


    ),
  ];
  List <Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),


  ];

  void changeBottomNavBAr(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }


  List <dynamic> business = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'business',
            'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value) {
        // print(value.data['articles'][0]['titles']);
        business = value.data['articles'];
        print(business);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List <dynamic> sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value) {
        // print(value.data['articles'][0]['titles']);
        sports = value.data['articles'];
        print(sports);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List <dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          }).then((value) {
        // print(value.data['articles'][0]['titles']);
        science = value.data['articles'];
        print(science);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List <dynamic> search = [];

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      // print(value.data['articles'][0]['titles']);
      search = value.data['articles'];
      print(search);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({ bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }


}
