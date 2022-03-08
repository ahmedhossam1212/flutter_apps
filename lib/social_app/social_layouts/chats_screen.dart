
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';

import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_layouts/chat_detals-screen.dart';
import 'package:newsapp/social_app/social_models/social_user.dart';
import 'package:newsapp/social_app/states/great_states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal:50),
              child: Container(height:1,
                  color: Colors.grey[400],
                  width: double.infinity),
            ),
            itemCount: SocialCubit.get(context).users.length );
      },

    );
  }

  Widget buildChatItem (SocialUserModel model,context) =>  InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ),
      );


    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage("${model.image}"),
                ),
                SizedBox(width: 15.0,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${model.name}",
                          style: TextStyle(
                            height: 1.3,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
                ),
              ]  ),
        ],
      ),
    ),
  );

}
