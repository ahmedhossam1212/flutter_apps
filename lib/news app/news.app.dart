import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/news%20app/cubit.dart';
import 'package:newsapp/news%20app/states.dart';



class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> NewsCubit())
        ],
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state)
          {
            var cubit = NewsCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'News App',
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brightness_4_outlined,
                    ),
                    onPressed: ()
                    {
                      NewsCubit.get(context).changeAppMode();
                    },
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBAr(index);
                },
                items: cubit.bottomItems,
              ),
            );
          },
        ),
      ),
    );
  }
}