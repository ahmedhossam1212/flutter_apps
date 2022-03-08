
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/componnents/constans.dart';
import 'package:newsapp/social_app/social_layouts/chats_screen.dart';
import 'package:newsapp/social_app/social_layouts/feeds_screen.dart';
import 'package:newsapp/social_app/social_layouts/post_screen.dart';
import 'package:newsapp/social_app/social_layouts/sitting_screen.dart';
import 'package:newsapp/social_app/social_layouts/user.dart';
import 'package:newsapp/social_app/social_models/message_model.dart';
import 'package:newsapp/social_app/social_models/post_model.dart';
import 'package:newsapp/social_app/social_models/social_user.dart';
import 'package:newsapp/social_app/states/great_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

static  SocialCubit get(context)=> BlocProvider.of(context);

  SocialUserModel? userModel;
  void getSocialUserData()
  {
    emit(SocialGetLoadingState());

     FirebaseFirestore.instance
         .collection('users')
         .doc(uId)
         .get()
         .then((value)
     {  print(value.data());
      userModel = SocialUserModel.fromJason(value.data()!);
       emit(SocialGetUserSuccessState());
     })
         .catchError((error){
           print(error.toString());
           emit(SocialGetUserErrorState(error.toString()));
     });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen(),
    NewPostScreen()

  ];
  List <String> titles=[
    "Home",
    "Chats",
    "Users",
    "Setting",
  ];

  void SocialChangeBottomNav (int index)
  {
    if(index==1)
      {
        getUsers();
      }

   if( index==4 ) {
      emit(SocialNewPostState());
    } else
     {
       currentIndex = index;
       emit(SocialChangeBottomNavState());
     }

  }

  File ? profileImage;
  var picker = ImagePicker();

  Future <void> getProfileImage() async
  {

    final pickedFile = await picker.pickImage
      (source: ImageSource.gallery);

    if (pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePikedErrorState());
    }
}


  File ? coverImage;


  Future <void> getCoverImage() async
  {

    // ignore: deprecated_member_use
    final pickedFile = await picker.pickImage
      (source: ImageSource.gallery);

    if (pickedFile != null)
    {
     coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No cover image selected.');
      emit(SocialCoverImagePikedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserInfo({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    if (profileImage != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
    } else if (coverImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else if (profileImage != null && coverImage != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      uId: userModel!.uId,
      bio: bio,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getSocialUserData();
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUserUpdateErrorState());
    });
  }

  File ? postImage;


  Future <void> getPostImage() async
  {

    final pickedFile = await picker.pickImage
      (source: ImageSource.gallery);

    if (pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePikedSuccessState());
    } else {
      print('No cover image selected.');
      emit(SocialPostImagePikedErrorState());
    }
  }
  void removePostImage()
  {
    postImage=null;
    emit(SocialRemovePostImageState());
  }

void uploadPostImage({

  required String dateTime,
  required String text,
})
{
  emit(SocialCreatePostLoadingState());
   firebase_storage.FirebaseStorage.instance.ref()
  .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
  .putFile(postImage!)
  .then((value){
    value.ref.getDownloadURL().then((value) {
      print(value);
      createPost(
          dateTime: dateTime,
          text: text,
        postImage: value,
      );

    }).catchError((error){
            emit(SocialCreatePostErrorState());

    });
   }).catchError((error){
     emit(SocialCreatePostErrorState());
   });

}


  void createPost({
    required String dateTime,
    required String text,
    String ? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    SocialPostModel model = SocialPostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image:userModel!.image,
       dateTime: dateTime,
      postImage: postImage??"",
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
        emit(SocialCreatePostSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  List<SocialPostModel> posts =[];
  List<String> postsId =[];
  List <int> likes =[]; 

  void getPosts()
  {  emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value){
          value.docs.forEach((element) { 
            element.reference
            .collection('likes')
            .get()
            .then((value){
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(SocialPostModel.fromJason(element.data()));
            })
            .catchError((error){});

          });

          SocialGetPostsSuccessState();
    }).catchError((error){
      emit(SocialGetPostsErrorState(error.toString()));
    });

  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true
    })
        .then((value){
          emit(SocialLikePostSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List  <SocialUserModel> users =[] ;

  void getUsers()
  {   users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      value.docs.forEach((element)
      {
        if(element.data()['uId'] !=userModel!.uId)
        users.add(SocialUserModel.fromJason(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });

  }


    void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,

})
  { MessageModel model = MessageModel(
    text: text,
     senderId: userModel!.uId,
   receiverId: receiverId,
    dateTime: dateTime,
  );
  FirebaseFirestore.instance
      .collection("users")
      .doc(userModel!.uId)
      .collection('chats')
      .doc(receiverId)
      .collection("messages")
      .add(model.toMap())
      .then((value) {
        emit(SocialSendMessageSuccessState());
  })
      .catchError((error){
       emit( SocialSendMessageErrorState());
  });

  FirebaseFirestore.instance
      .collection("users")
      .doc(receiverId)
      .collection('chats')
      .doc(userModel!.uId)
      .collection("messages")
      .add(model.toMap())
      .then((value) {
    emit(SocialSendMessageSuccessState());
  })
      .catchError((error){
    emit( SocialSendMessageErrorState());
  });

  }
  List<MessageModel> messages = [];

  void getMessage({
  required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
         .orderBy("dateTime")
        .snapshots()
        .listen((event) 
    {
      messages =[];

          event.docs.forEach((element)
          {
            messages.add(MessageModel.fromJason(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }
  
  }

