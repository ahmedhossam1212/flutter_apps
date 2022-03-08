import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/social_app/social_layouts/social_home.dart';
import '../../componnents/componants.dart';
import '../social_cubit/register_cubit.dart';
import '../states/register_states.dart';

class RegisterSocialScreen  extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialRegisterCubit() ,
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state)
    {  if(state is SocialCreateUserSuccessState)
      {
        navigateAndFinish(context, SocialHome());
      }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form( key:formKey,
                  child: Column( mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ) ,
                        ),
                        SizedBox(height: 10,),
                        Text("Register to communicate with friends ",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,

                            )
                        ),
                        SizedBox(height: 50.0,),
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

                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: ( String value)
                          {
                            if(  value.isEmpty )
                            {
                              return "  Password must not be empty ";
                            }
                            return null;
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword ,
                        ),
                        SizedBox(height: 10.0,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: ( String value)
                          {
                            if(  value.isEmpty )
                            {
                              return " Password must not be empty";
                            }
                            return null;
                          },
                          label: "Confirm password",
                          prefix: Icons.lock,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword ,
                        ),
                        SizedBox(height: 10.0,),

                        defaultFormField(

                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value)
                            {
                              if(value.isEmpty )
                              {
                                return 'Name must not be empty';
                              }
                            },
                            label: "Name",
                            prefix: Icons.person),
                        SizedBox(height: 10.0,),
                        defaultFormField(controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value)
                            {
                              if(value.isEmpty )
                              {
                                return 'Phone must not be empty';
                              }
                            },
                            label: "Phone",
                            prefix: Icons.phone),


                        SizedBox(height: 30.0,),


                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState  ,
                          builder: (context)=>defaultButton(
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }

                            },
                            text: "REGISTER",
                            isUpperCase: true,
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),

                      ]),
                ),
              ),

            ),
          );
        },

      ),
    );
  }
}
