import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/states/great_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context,state){

        var userModel = SocialCubit.get(context).userModel;
        var profileIMage = SocialCubit.get(context).profileImage;
        var coverImage= SocialCubit.get(context).coverImage;

        nameController .text= userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile",),
            titleSpacing: 0.0,
            actions: [
              defaultTextButton(function: (){
                   SocialCubit.get(context).updateUser(
                       name: nameController.text,
                       phone: phoneController.text,
                       bio: bioController.text
                   );
              }, text: "Update"),
              SizedBox(width: 15.0,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if ( state is SocialUserUpdateLoadingState )
                  LinearProgressIndicator(),
                  SizedBox(height: 10.0,),
                  Container(
                    height:190.0 ,
                    child: Stack(  alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack( alignment: AlignmentDirectional.topEnd,
                            children: [Container(
                              height:140.0 ,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0) ,
                                    topRight: Radius.circular(4.0) ,
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ? NetworkImage("${userModel.cover}") : FileImage(coverImage) as ImageProvider ,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                              IconButton(onPressed: (){
                                SocialCubit.get(context).getCoverImage();
                              },
                                  icon: CircleAvatar( backgroundColor: Colors.white,
                                  radius: 20.0,
                                  child: Icon(Icons.camera_alt,
                                   size: 16.0,
                                    color: Colors.black,
                                  ),
                                  ),
                              ),
                            ]
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack( alignment: AlignmentDirectional.bottomEnd,
                          children:[ CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius:45.0,
                              backgroundImage:  profileIMage == null? NetworkImage("${userModel.image}")  : FileImage(profileIMage)  as ImageProvider ,

                            ),
                          ),
                          CircleAvatar( radius: 16,
                            backgroundColor: Colors.white,
                            child: IconButton(onPressed: (){
                              SocialCubit.get(context).getProfileImage();
                            },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                size: 10.0,)),
                          )
                          ]
                        ),

                      ],

                    ),
                  ),
                  SizedBox(height: 10.0,),
                  // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage!= null )
                  // Row(
                  //   children: [
                  //     if ( SocialCubit.get(context).profileImage !=null)
                  //     Expanded(
                  //       child: Column(
                  //         children: [
                  //           defaultButton(
                  //               function:(){
                  //                   SocialCubit.get(context).uploadProfileImage(
                  //                       name: nameController.text,
                  //                       bio: bioController.text,
                  //                       phone: phoneController.text,
                  //                   );
                  //               } ,
                  //               text:"Upload Profile" ),
                  //          LinearProgressIndicator(),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(width: 10,),
                  //     if(SocialCubit.get(context).coverImage!= null)
                  //     Expanded(
                  //       child: Column(
                  //         children: [
                  //           defaultButton(
                  //               function:(){
                  //
                  //               } ,
                  //               text:"Upload Cover" ),
                  //
                  //
                  //          // LinearProgressIndicator(),
                  //         ],
                  //       ),
                  //     ),
                  //
                  //   ],
                  // ),
                  // SizedBox(height: 20.0,),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                          return 'Name most not be empty';
                      },
                      label: "Name",
                      prefix: Icons.supervised_user_circle
                  ),
                  SizedBox(height: 10.0,),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                          return 'Phone most not be empty';
                      },
                      label: "Phone",
                      prefix: Icons.phone
                  ),
                  SizedBox(height: 10.0,),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                          return 'Bio most not be empty';
                      },
                      label: "Bio",
                      prefix: Icons.text_fields
                  )


                ],
              ),
            ),
          ) ,

        );
      },

    );
  }
}
