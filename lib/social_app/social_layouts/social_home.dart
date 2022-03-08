import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/social_app/social_cubit/great_cubit.dart';
import 'package:newsapp/social_app/social_layouts/post_screen.dart';
import 'package:newsapp/social_app/states/great_states.dart';

class SocialHome  extends StatelessWidget
{
  const SocialHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      { if (state is SocialNewPostState )
        {
          navigateTo(context, NewPostScreen());
        }

    } ,
      builder: (context,state)
      {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:
            Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications),
              iconSize: 20.0,
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.search),
                iconSize: 20.0,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex]  ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex ,
              onTap: (index)
              {
                cubit.SocialChangeBottomNav(index);
              }, 
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Users'

              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded),
                label: 'Settings',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_upload),
                label: 'Post',

              ),
            ],

          ),


        );
      } ,

    );
  }
}
