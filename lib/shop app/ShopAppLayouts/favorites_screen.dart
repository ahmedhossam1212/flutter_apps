import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../componnents/componants.dart';
import '../cubitShopApp/cubit2.dart';
import '../cubitShopApp/states2.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) { return ConditionalBuilder(
        condition: state is! ShopLoadingGetFavoritesState,

        builder:(context)=> ListView.separated(
            itemBuilder: (context, index) => buildListProductScreen(
                ShopCubit.get(context).favoritesModel!.data!.data[index].product,context),
            separatorBuilder:(context, index) => SizedBox(
              height: 20.0,
            ),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
        ),
        fallback: (context)=> CircularProgressIndicator(),
      );
      },


    );
  }




}
