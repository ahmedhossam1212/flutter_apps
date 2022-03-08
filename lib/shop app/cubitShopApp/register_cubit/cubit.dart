import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/remote/dio.helper.dart';
import 'package:newsapp/shop%20app/cubitShopApp/register_cubit/states.dart';
import 'package:newsapp/shop%20app/endPoint.dart';
import 'package:newsapp/shop%20app/models/loginModel.dart';


class  ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

late  ShopLoginModel loginModel;

void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,

})
{
  emit(ShopRegisterLoadingState());

 DioHelper.postData(url: REGISTER,
     data:
     {
       'email': email,
       'password': password,
       'name':name,
       'phone':phone,
     },

 ).then((value)
 { print(value.data);
 loginModel= ShopLoginModel.fromJson(value.data);
 print(loginModel.data!.token);
 print(loginModel.message);
 print(loginModel.status);
 emit(ShopRegisterSuccessState(loginModel));
 } ).catchError((error)
 {
   emit(ShopRegisterErrorState(error.toString()));
 });

}


IconData suffix = Icons.visibility_outlined;
bool isPassword = true;
void changePasswordVisibility ()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
 emit(ShopRegisterChangePasswordVisibilityState());

}


}