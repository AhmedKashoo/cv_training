import 'package:bloc/bloc.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/Models/ShopApp/ShopLoginModel.dart';
import 'package:cv_training/Modules/shop%20app/search/searchCubit/state.dart';
import 'package:cv_training/Network/Remote/Shop%20Dio/dio.dart';
import 'package:cv_training/Network/local/Cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/ShopApp/CategoriesModel.dart';
import '../../../Models/ShopApp/ChangeFavouriteModel.dart';
import '../../../Models/ShopApp/FavouriteModel.dart';
import '../../../Models/ShopApp/HomeModel.dart';
import '../../../Modules/shop app/cateogries/cateogries_Screen.dart';
import '../../../Modules/shop app/favourite/favourite_Screen.dart';
import '../../../Modules/shop app/products/products_Screen.dart';
import '../../../Modules/shop app/search/search_Screen.dart';
import '../../../Modules/shop app/setting/setting_Screen.dart';
import '../../../shared/components/constant.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int current_Index=0;

  List<Widget>Bottom_Screeen=[
    Product_Screen(),
    cateogries_Screen(),
    favourite_Screen(),
    SettingsScreen (),
  ];
  void changNavIndex(int index){
    current_Index=index;
    emit(ShopChangeNavBarState());
  }
  HomeModel? homeModel;
  Map<dynamic,bool>favourite={};

  void GetData(){
    emit(ShopLoadingHomeDataState());
    ShopDioHelper.getData(url: "https://student.valuxapps.com/api/home",token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
     // print(homeModel?.data?.products![0]!.name.toString());
      homeModel!.data!.products!.forEach((element) {
        favourite.addAll(
          {
            element.id!.toInt() :element.inFavorites!
          }
        );
      });
      print(favourite.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  
  CategoriesModel? categoriesModel;
  void Getcategories(){

    ShopDioHelper.getData(url: "https://student.valuxapps.com/api/categories",token: token).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel?.data?.data![0]!.toString());
      emit(ShopSuccesscategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorcategoriesState());
    });
  }
  ChangeFavouriteModel ?changeFavouriteModel;
  void changeFavourite(int ProductId){
    favourite[ProductId]= !favourite[ProductId]!;
    emit(ShopChangeFavouriteState());
    ShopDioHelper.postData(url: "https://student.valuxapps.com/api/favorites", data:{
      'product_id':ProductId.toInt()
    } ,token: token).then((value)  {
      changeFavouriteModel=ChangeFavouriteModel.fromJson(value.data);
      if(!changeFavouriteModel!.status!){
        favourite[ProductId]= !favourite[ProductId]!;
      }else{
        GetFavourite();
      }
      emit(ShopSuccessChangeFavouriteState(changeFavouriteModel!));
    }).catchError((onError){
      favourite[ProductId]= !favourite[ProductId]!;
      emit(ShopErrorChangeFavouriteState(onError));
      print(onError);
    });
  }
  FavouriteModel? favouriteModel;
  void GetFavourite(){
    emit(ShopLoadingGetFavoritesState());

    ShopDioHelper.getData(url: "https://student.valuxapps.com/api/favorites",token: token).then((value) {
      favouriteModel=FavouriteModel.fromJson(value.data);
      print(favouriteModel?.data?.data![0].product!.name);
      emit(ShopSuccessGetFavState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavState());
      print(error.toString());
    });
  }

  ShopLoginModel? userdata;
  void GetUserData(){


    ShopDioHelper.getData(url: "https://student.valuxapps.com/api/profile",token: token).then((value) {
      emit(ShopLoadingGetUserDataState());
      userdata=ShopLoginModel.fromJson(value.data);
      print(userdata?.data?.name);
      emit(ShopSuccessGetUserDataState(userdata!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }
  void UodateUserData({required String email,required String name,required String phone}){
    emit(ShopLoadingUpdateState());

    ShopDioHelper.putData(url: "https://student.valuxapps.com/api/update-profile",token: token, data: {
      "email": email,
      "name":name,
      "phone":phone
    }).then((value) {
      userdata=ShopLoginModel.fromJson(value.data);
      print(userdata?.data?.name);
      emit(ShopSuccessUpdateState(userdata!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }


}