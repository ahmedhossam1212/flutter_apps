import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shop%20app/cubitShopApp/cubit2.dart';
import 'package:newsapp/shop%20app/cubitShopApp/states2.dart';
import 'package:newsapp/shop%20app/models/categoris_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) { return ListView.separated(
          itemBuilder: (context, index) =>buildCatItem(
              ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder:(context, index) => SizedBox(
            height: 20.0,
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
      );
      },


    );
  }

  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image!),
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(model.name!,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
