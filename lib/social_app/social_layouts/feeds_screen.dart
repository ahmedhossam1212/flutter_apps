import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_models/post_model.dart';
import 'package:newsapp/social_app/states/great_states.dart';
import 'package:newsapp/styles/colors/colors.dart';

class FeedsScreen  extends StatelessWidget {
  const FeedsScreen ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
           condition: SocialCubit.get(context).posts.length>0,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 20.0,
                  margin: EdgeInsets.all(8.0,),
                  child: Image(image:
                  NetworkImage("https://img.freepik.com/free-photo/senior-european-race-couple-putting-aprons-kitchen_1157-49164.jpg?size=626&ext=jpg&uid=R65010531&ga=GA1.2.168883110.1643388241"),
                    width: double.infinity ,
                  ) ,
                ),
                ListView.separated(itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder:(context,index)=>SizedBox(height: 10) ,
                  itemCount: SocialCubit.get(context).posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),

              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      } ,
     
    );
  }
  Widget buildPostItem(SocialPostModel model,context,index) =>  Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 20.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(Icons.check_circle,
                          color: defaultColor,
                          size: 12.0 ,
                        )
                      ],
                    ),
                    Text("${model.dateTime}",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[400],
                          height: 1.3,
                        )
                    ),
                  ],
                ),),
                SizedBox(width: 15.0,),
                IconButton(onPressed: (){}, icon: Icon( Icons.more_horiz))

              ], ),
            SizedBox(height: 10,),
            Text("${model.text}",
              style: TextStyle(
                height: 1.2,
              ),
            ),
            // Container( width: double.infinity,
            //   child: Wrap(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(
            //           end: 3.0,
            //         ),
            //         child: Container( height: 20.0,
            //           child: MaterialButton(
            //             onPressed:(){},
            //             child: Text("#Wikipedia",
            //                 style: Theme.of(context).textTheme.caption!.copyWith(
            //                     color: Colors.blue
            //                 )
            //             ),
            //             minWidth: 1.0,
            //             padding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
              if (model.postImage !=  "")
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card( clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: EdgeInsets.zero,
                child: Image(image:
                NetworkImage('${model.postImage}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5 ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.favorite,
                            color: Colors.grey ,),
                          Text("${SocialCubit.get(context).likes[index]}",
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.grey[400]
                              )
                          ),


                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Row( mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.mode_comment_outlined,
                            color: Colors.grey,),
                          Text("0",
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.grey[400]
                              )
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage("${model.image}"),
                        ),
                        SizedBox(width: 10.0,),
                        Text("Write A comment ...",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row( mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite,
                        color: SocialCubit.get(context).likes[index] > 0 ? Colors.red : Colors.grey ),
                      Text("Like",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[400]
                          )
                      ),


                    ],
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){},
                  child: Row( mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.mode_comment_outlined,
                        color: Colors.grey,),
                      Text("Comment",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[400]
                          )
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
  );
}
