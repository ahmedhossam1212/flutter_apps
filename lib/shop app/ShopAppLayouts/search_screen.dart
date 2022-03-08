import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/shop%20app/cubitShopApp/search/cubit.dart';
import 'package:newsapp/shop%20app/cubitShopApp/search/states.dart';


class SearchScreen extends StatelessWidget {

  var formKey= GlobalKey<FormState>();
   var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context )=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){} ,
        builder:(context,state){
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key:formKey ,

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                            controller: searchController,
                            type: TextInputType.text,
                            validate: (String value)
                            {
                              if(value.isEmpty)
                                {
                                 return ' Enter text to search';
                                }
                            },
                            label: 'Search',
                            prefix: Icons.search,
                            onSubmit:(String text)
                            {
                              SearchCubit.get(context).search(text);
                            } ,

                        ),
                      ),
                      SizedBox(height: 10.0,),
                      if(state is SearchLoadingState )
                      LinearProgressIndicator(),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProductScreen(SearchCubit.get(context).model!.data!.data[index],context),
                          separatorBuilder:(context, index) => SizedBox(
                            height: 20.0,
                          ),
                          itemCount: SearchCubit.get(context).model!.data!.data.length,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
          );
        } ,

      ),
    );
  }
}
