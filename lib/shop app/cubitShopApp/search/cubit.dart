import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/remote/dio.helper.dart';
import 'package:newsapp/shop%20app/cubitShopApp/search/states.dart';
import 'package:newsapp/shop%20app/models/search_model.dart';
import '../../../componnents/constans.dart';
import '../../endPoint.dart';

class SearchCubit extends Cubit <SearchStates>
{
  SearchCubit() : super (SearchInitialState());
  static SearchCubit get(context) =>  BlocProvider.of(context);

  SearchModel ?model;

  void search (String text)
  {  SearchLoadingState();

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        }).then((value) {
          model= SearchModel.fromJson(value.data);
          emit(SearchSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}