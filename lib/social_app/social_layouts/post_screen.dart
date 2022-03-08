import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/states/great_states.dart';

import '../../styles/colors/colors.dart';

class NewPostScreen extends StatelessWidget {

 var dateTimeController= TextEditingController();
 var textController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){} ,
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: Text(
                "Create Post"),
            actions: [
              defaultTextButton(function: (){
                 var now= DateTime.now();
                if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text);
                  }else{
                  SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text);
                }

              }, text: 'Post'),
              SizedBox(width: 10.0,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage("https://img.freepik.com/free-photo/full-length-portrait-handsome-successful-businessman_171337-18653.jpg?size=338&ext=jpg&uid=R65010531&ga=GA1.2.1925568693.1646082132"),
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Ahmed Hossam",
                              style: TextStyle(
                                height: 1.3,
                              ),
                            ),
                            Icon(Icons.check_circle,
                              color: defaultColor,
                              size: 12.0 ,
                            )
                          ],
                        ),
                        Text("April 16,4,2022 at 5:00 pm",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[400],
                              height: 1.3,
                            )
                        ),
                      ],
                    ),),
                    SizedBox(width: 15.0,),


                  ], ),
                Expanded(
                  child: TextFormField( controller: textController,
                    decoration: InputDecoration(
                      hintText: "what's in your mind ..",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage != null)
                Stack( alignment: AlignmentDirectional.topEnd,
                    children: [Container(
                      height:140.0 ,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                      IconButton(onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      },
                        icon: CircleAvatar( backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(Icons.close,
                            size: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]
                ),
                 SizedBox(height: 20.0,),
                 Row( mainAxisAlignment: MainAxisAlignment.center,
                   children: [ 
                     Expanded(
                       child: TextButton(onPressed: (){
                         SocialCubit.get(context).getPostImage();
                       }, child: Row(
                         children: [
                           Icon(Icons.image),
                           SizedBox(width: 5.0,),
                           Text("add photo"),
                         ],
                       ),
                       ),
                     ),
                     Expanded(
                       child: TextButton(onPressed: (){}, child: Row(
                         children: [
                           Text("        #Tags#"),
                         ],
                       ),
                       ),
                     ),
                   ],
                 )

              ],
            ),
          )  ,
        );
      },
    );

  }
}
