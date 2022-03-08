
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/social_app/social_models/social_user.dart';

import '../states/register_states.dart';

class  SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  }) {

    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId:value.user!.uid
      );

    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  })
{    SocialUserModel model = SocialUserModel(
  name:name,
  email: email,
  phone: phone,
  uId: uId,
  isEmailVerified: false,
  image: 'https://img.freepik.com/free-photo/fun-3d-cartoon-casual-character_183364-80059.jpg?size=626&ext=jpg&uid=R65010531&ga=GA1.2.168883110.1643388241',
   bio:'write your bio',
  cover: 'https://img.freepik.com/free-photo/portrat-caucasian-professional-male-athlete-runner-training-isolated-black_155003-42226.jpg?size=626&ext=jpg&uid=R65010531&ga=GA1.1.168883110.1643388241',

);

FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .set(model.toMap())
    .then((value){

      emit(SocialCreateUserSuccessState());
    })
    .catchError((error){

      emit(SocialCreateUserErrorState(error.toString()));
    });
}

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

}
