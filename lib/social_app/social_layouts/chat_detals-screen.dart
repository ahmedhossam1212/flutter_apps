import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_models/message_model.dart';
import 'package:newsapp/social_app/social_models/social_user.dart';
import 'package:newsapp/social_app/states/great_states.dart';
import 'package:newsapp/styles/colors/colors.dart';


class ChatDetailsScreen extends StatelessWidget {
  var textController = TextEditingController();

SocialUserModel? userModel;

 ChatDetailsScreen({
 this.userModel,
});

  @override
  Widget build(BuildContext context) {

    return Builder(

      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage("${userModel!.image}"),
                  ),
                  SizedBox(width: 15.0,),
                  Text("${userModel!.name}"),
                ]),
              ),
              body: ConditionalBuilder(
                condition: true ,
                builder: (context)=> Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index)
                            { var message = SocialCubit.get(context).messages[index];

                              if(SocialCubit.get(context).userModel!.uId == message.senderId ) {
                              return buildMyMessage(message);
                            }else {
                                return buildMessage(message);
                              }
                              } ,
                            separatorBuilder: (context,index)=> SizedBox(
                                height: 5.0) ,
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),

                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: "type your message..",
                                  border: InputBorder.none,

                                ),
                              ),
                            ),
                            Container( height: 40.0,
                              color: defaultColor ,

                              child: MaterialButton( minWidth: 1.0,
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: textController.text );
                                },
                                child:Icon(Icons.send,
                                  size:16.0,
                                  color:Colors.white,

                                ) ,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),

              ) ,
            );
          },
        );
      }
    );
  }

  Widget buildMessage(MessageModel model) =>  Align( alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 8.0,
        ),
        child: Text("${model.text}")),
  );
  Widget buildMyMessage(MessageModel model) => Align( alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(color: defaultColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 8.0,
        ),
        child: Text("${model.text}")),
  );
}
