
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/shop%20app/ShopAppLayouts/shop%20login.dart';
import 'package:newsapp/shop%20app/cubitShopApp/cubit2.dart';
import 'package:newsapp/shop%20app/cubitShopApp/states2.dart';
import 'package:newsapp/styles/colors/colors.dart';

class SettingsScreen extends StatelessWidget {


  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context, state) {},
      builder: (context,state)
      {
        var model =ShopCubit.get(context).userModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;




        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null ,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String  value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Name must not be Empty ';
                          }
                        },
                        label: "Name",
                        prefix: Icons.person,

                    ),
                    SizedBox(height: 10.0,),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String  value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Email must not be Empty ';

                          }
                          return null;
                        },
                        label: "Email Address",
                        prefix: Icons.email,

                    ),
                    SizedBox(height: 10.0,),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String  value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Phone must not be Empty ';
                          }
                          return null;
                        },
                        label: "Phone Number",
                        prefix: Icons.phone,


                    ),

                    SizedBox(height: 30.0,),

                    MaterialButton( minWidth: double.infinity,
                        color: defaultColor,
                        onPressed: ()
                    {
                      CacheHelper.removeData(key: "token",).then((value){
                        if(value)
                          {
                            navigateAndFinish(context, LoginScreenShop());
                          }
                      } );
                    },
                        child: Text("LOGOUT"
                            "",style: TextStyle(
                          color: Colors.white
                        ),)),

                   MaterialButton(
                       onPressed: (){
                         if(formKey.currentState!.validate())
                         {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                     minWidth: double.infinity,
                     color: defaultColor,
                     child:Text('UPDATE',
                     style: TextStyle(
                       color: Colors.white
                     ),
                     ) ,


                       ),

                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),


        );
      },

    );
  }
}
