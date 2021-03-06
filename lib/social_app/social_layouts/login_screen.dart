import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/social_app/social_layouts/register_screen.dart';
import 'package:newsapp/social_app/social_layouts/social_home.dart';
import '../../componnents/componants.dart';
import '../../network/local/cash-helper.dart';
import '../social_cubit/login_cubit.dart';
import '../states/login_state.dart';

class SocialLoginScreen extends StatelessWidget {
 var formKey = GlobalKey<FormState>();
 var passwordController = TextEditingController();
 var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit() ,
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
            {
              showToast(
                  text: 'error',
                  state: ToastState.Error);
            }
          if (state is SocialLoginSuccessState)
            {

              CacheHelper.saveData(key: 'uId',
                  value: state.uId).
              then((value){


                navigateAndFinish(context, SocialHome());

              });

            }
        } ,
        builder:  (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form( key:formKey,
                  child: Column( mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ) ,
                        ),
                        SizedBox(height: 10,),
                        Text("Login to communicate with friends",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,

                            )
                        ),
                        SizedBox(height: 100.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                            {return"please enter your email address";}
                            return null;
                          },
                          label: "Email Address",
                          prefix: Icons.email,
                        ) ,
                        SizedBox(height: 10.0,),
                        defaultFormField(
                          onSubmit: (value)
                          {
                            if (formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: ( String value)
                          {
                            if(  value.isEmpty )
                            {
                              return " please enter your password ";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword ,
                          onChange: (value){},


                        ),
                        SizedBox(height: 30.0,),


                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }

                            },
                            text: "LOGIN",
                            isUpperCase: true,
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),
                        Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            defaultTextButton( function:()
                            {
                              navigateTo(context, RegisterSocialScreen() );
                            }
                                , text: "REGISTER NOW")
                          ],
                        ),



                      ]
                  ),
                ),
              ),
            ),

          );
        } ,

      ),
    );
  }
}
