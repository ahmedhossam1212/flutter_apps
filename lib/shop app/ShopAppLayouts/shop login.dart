import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/shop%20app/ShopAppLayouts/home.dart';
import 'package:newsapp/shop%20app/ShopAppLayouts/regester.dart';
import 'package:newsapp/shop%20app/cubitShopApp/cubit.dart';
import 'package:newsapp/shop%20app/cubitShopApp/states.dart';
import '../../componnents/componants.dart';
import '../../componnents/constans.dart';



class LoginScreenShop extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();




    return BlocProvider(
       create: (BuildContext context) => ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status==true)
                {
                  print(state.loginModel.message);

                  CacheHelper.saveData(key: 'token',
                      value: state.loginModel.data!.token).
                  then((value){
                    token = state.loginModel.data!.token;

                    navigateAndFinish(context, HomeShop());

                  });

                }else
                  {
                     print(state.loginModel.message);
                    showToast(
                        text: state.loginModel.message!,
                        state: ToastState.Error);
                  }
            }
        },
        builder: (context,state)
        {
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
                      Text("Login to browse our hot offers",
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
                            ShopLoginCubit.get(context).userLogin(
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
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPressed: ()
                        {
                          ShopLoginCubit.get(context).changePasswordVisibility();
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword ,
                        onChange: (value){},


                      ),
                      SizedBox(height: 30.0,),


                      ConditionalBuilder(
                       condition: state is! ShopLoginLoadingState,
                        builder: (context)=>defaultButton(
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
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
                            navigateTo(context, Register() );
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
        },

      ),
    );
  }
}
