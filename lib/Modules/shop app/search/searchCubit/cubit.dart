import 'package:bloc/bloc.dart';
import 'package:cv_training/Models/ShopApp/SearchModel.dart';
import 'package:cv_training/Modules/shop%20app/search/searchCubit/state.dart';
import 'package:cv_training/Network/Remote/Dio.dart';
import 'package:cv_training/Network/Remote/Shop%20Dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/constant.dart';

class Searchcubit extends Cubit<SearchState> {
  Searchcubit(SearchInitialState searchInitialState) :super(SearchInitialState());

  static Searchcubit get(context) => BlocProvider.of(context);
  late SearchModel searchModel;

  void getSearch(String text) {
    emit(SearchInitialState());
    ShopDioHelper.postData(
        url: "https://student.valuxapps.com/api/products/search",
        token: token,
        data: {
          'text': text
        }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSucessState(searchModel));
    }).catchError((error) {
      print(error);
      emit(SearchErrorState());
    });
  }
}