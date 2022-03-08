
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/network/remote/dio.helper.dart';
import 'package:newsapp/news%20app/cubit.dart';
import 'package:newsapp/news%20app/states.dart';
import 'package:newsapp/shop%20app/cubitShopApp/cubit.dart';
import 'package:newsapp/shop%20app/cubitShopApp/cubit2.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_layouts/login_screen.dart';
import 'package:newsapp/social_app/social_layouts/social_home.dart';
import 'package:newsapp/styles/themes.dart';

import 'componnents/constans.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  //
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  // });

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key:'isDark');

  Widget widget;
  // dynamic onBoarding = CacheHelper.getData(key:'onBoarding');
 uId = CacheHelper.getData(key:'uId');

  //
  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = HomeShop();
  //
  //   else {
  //     widget = LoginScreenShop();
  //   }
  // }
  //  else {
  //   widget =  OnBoardingScreen();
  // }
  if (uId != null)
    {
      widget =SocialHome();
    } else
      {
        widget = SocialLoginScreen();
      }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final isDark;
  final startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(),),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
          ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) =>
          SocialCubit()
            ..getSocialUserData()
            ..getPosts()
          ,
        ),

      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: NewsCubit
                .get(context)
                .isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}