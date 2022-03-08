import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_layouts/edit_profile.dart';
import 'package:newsapp/social_app/states/great_states.dart';

import 'login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height:190.0 ,
                child: Stack(  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height:140.0 ,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0) ,
                              topRight: Radius.circular(4.0) ,
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${userModel!.cover}"),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius:45.0,
                        backgroundImage: NetworkImage("${userModel.image}"),
                      ),
                    ),

                  ],

                ),
              ),
              SizedBox(height: 5.0,),
              Text("${userModel.name}"),
              Text("${userModel.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height:10.0,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text("Posts"),
                          Text("100",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text("photos"),
                          Text("545",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text("Followers"),
                          Text("100k",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text("Followings"),
                          Text("110",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: (){}, child: Text("Add Photos")) ,
                    ),
                    SizedBox(width: 8.0,),
                    OutlinedButton(
                        onPressed: (){
                          navigateTo(context, EditProfileScreen());
                        },
                        child:Icon(Icons.edit,
                        size: 15.0,)),
                  ],
                ),
              ),
              defaultTextButton(function: (){
                CacheHelper.removeData(key: 'uId').then((value) {
                  if(value)
                    {
                      navigateAndFinish(context, SocialLoginScreen());
                    }
                });


              }, text: "logout")

            ],

          ),
        );
      },

    );
  }
}
