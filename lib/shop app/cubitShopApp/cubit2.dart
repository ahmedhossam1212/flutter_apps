import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/remote/dio.helper.dart';
import 'package:newsapp/shop%20app/models/Home_Model.dart';
import 'package:newsapp/shop%20app/models/categoris_model.dart';
import 'package:newsapp/shop%20app/models/change_favorites_model.dart';
import 'package:newsapp/shop%20app/models/favorites_model.dart';
import 'package:newsapp/shop%20app/models/loginModel.dart';
import '../../componnents/constans.dart';
import '../ShopAppLayouts/categories_screen.dart';
import '../ShopAppLayouts/favorites_screen.dart';
import '../ShopAppLayouts/settings.dart';
import '../endPoint.dart';
import 'states2.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super (ShopInitialState());
  static ShopCubit get(context)=> BlocProvider.of(context);

int currentIndex = 0;
List <Widget> bottomScreen=[

  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen(),
];

void ChangeBottom(int index)
{
 currentIndex=index;
 emit(ShopChangeBottomNavState());
}

HomeModel? homeModel;
Map <dynamic,dynamic> favorites ={ };

void getHomeData()
{
  emit(ShopLoadingHomeDataState());

  DioHelper.getData(
      url: HOME,
    token:token ,
  ).then((value){
    homeModel= HomeModel.fromJson(value.data);
    // print(homeModel!.status.toString());
    // print(homeModel!.data!.banners[0].image);
    // print(homeModel!.data!.banners[0].id);

    homeModel!.data!.products.forEach((element) {
      favorites.addAll({
       element.id! :  element.inFavorites!
      });
    });


    emit(ShopSuccessHomeDataState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });
}

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value){
      categoriesModel= CategoriesModel.fromJson(value.data);
      print(homeModel!.status.toString());
      print(homeModel!.data!.banners[0].image);
      print(homeModel!.data!.banners[0].id);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorite (int? productId)
  {
    favorites[productId!] = !favorites[productId];
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {'product_id':productId,
            },
      token: token,
            )
        .then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
       if(changeFavoritesModel!.status==false)
         {
           favorites[productId] = !favorites[productId];
         }else
           {
             getFavorites();
           }

      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error)
        {   favorites[productId] = !favorites[productId];
        print(error.toString());
          emit(ShopErrorChangeFavoritesState());
        });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel= FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel= ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());


    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone': phone,

      },
    ).then((value){
      userModel= ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}

