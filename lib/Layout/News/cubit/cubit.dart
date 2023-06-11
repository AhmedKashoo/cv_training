import 'package:cv_training/Layout/News/cubit/state.dart';
import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:cv_training/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Modules/Business/Business.dart';
import '../../../Modules/Science/Science.dart';
import '../../../Modules/Sport/sport.dart';
import '../../../Network/Remote/Dio.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit():super(InitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem>BottomNavItem=[
    BottomNavigationBarItem(
      icon: Icon(Icons.business_sharp),
      label: 'Bussiness',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget>screens=[
    Business(),
    Sport(),
    Science()
  ];
  void changeNavBar(int index){
    currentIndex=index;
    emit(BottomNavState());
  }
  List<dynamic>business=[];
  void getBusiness(){
    emit(NewsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        quary: {
          'country':'eg',
          'category':'business',
          'apiKey':'250ba371d54d4415b0796579c528f04d',
        }
    ).then((value) {
      print(value.data.toString());
      business=value.data['articles'];
      print(business.length);
      emit(NewsGetBusinessSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }
  List<dynamic>sports=[];
  void getSports(){
    emit(NewsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        quary: {
          'country':'eg',
          'category':'sport',
          'apiKey':'250ba371d54d4415b0796579c528f04d',
        }
    ).then((value) {
      print(value.data.toString());
      sports=value.data['articles'];
      print(sports.length);
      emit(SportGetBusinessSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SportGetBusinessErrorState(onError.toString()));
    });
  }
  List<dynamic>science=[];
  void getScience(){
    emit(NewsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        quary: {
          'country':'eg',
          'category':'science',
          'apiKey':'250ba371d54d4415b0796579c528f04d',
        }
    ).then((value) {
      print(value.data.toString());
      science=value.data['articles'];
      print(sports.length);
      emit(scienceGetBusinessSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(scienceGetBusinessErrorState(onError.toString()));
    });
  }
}