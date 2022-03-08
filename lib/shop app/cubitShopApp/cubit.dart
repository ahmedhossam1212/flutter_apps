
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/remote/dio.helper.dart';
import 'package:newsapp/shop%20app/cubitShopApp/states.dart';
import 'package:newsapp/shop%20app/models/loginModel.dart';

import '../endPoint.dart';

class  ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

late  ShopLoginModel loginModel;

void userLogin({
  required String email,
  required String password,

})
{
  emit(ShopLoginLoadingState());

 DioHelper.postData(url: LOGIN,
     data:
     {
       'email': email,
       'password': password,

     },

 ).then((value)
 { print(value.data);
 loginModel= ShopLoginModel.fromJson(value.data);
 print(loginModel.data!.token);
 print(loginModel.message);
 print(loginModel.status);
 emit(ShopLoginSuccessState(loginModel));
 } ).catchError((error)
 {
   emit(ShopLoginErrorState(error.toString()));
 });

}


IconData suffix = Icons.visibility_outlined;
bool isPassword = true;
void changePasswordVisibility ()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
 emit(ShopChangePasswordVisibilityState());

}


}