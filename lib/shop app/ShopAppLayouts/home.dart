import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';

import 'package:newsapp/shop%20app/cubitShopApp/cubit2.dart';
import 'package:newsapp/shop%20app/cubitShopApp/states2.dart';

import 'search_screen.dart';

class HomeShop extends  StatelessWidget {


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< ShopCubit,ShopStates >(
      listener: (context,index){},
      builder: (context,index){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Market"),
            actions: [
              IconButton(icon: Icon(Icons.search),onPressed: (){
                navigateTo(context, SearchScreen());
              },)

            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.ChangeBottom(index);

            },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home,),
                label: "Home",

                ),
                BottomNavigationBarItem(icon:Icon(Icons.apps,),
                  label: "Categories",

                ),
                BottomNavigationBarItem(icon:Icon(Icons.favorite,),
                  label: "Favorites",

                ),
                BottomNavigationBarItem(icon:Icon(Icons.settings,),
                  label: "Settings",

                ),
              ]),
        );
      },

    );
  }
}
