import 'package:bloc/bloc.dart';
import 'package:cv_training/shared/components/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';


import '../../../../Models/ShopApp/ShopLoginModel.dart';
import '../../../../Network/Remote/Shop Dio/dio.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
   ShopLoginModel? loginModel;
  LoginCubit() : super(LoginInitial());
 static LoginCubit get(context)=>BlocProvider.of(context);
 void UserLogin({required String email,required String password,}){
   emit(LoginLoading());
   ShopDioHelper.postData(url: "https://student.valuxapps.com/api/login", data: {
     "email": email,
     "password":password
   }).then((value) {
     loginModel=ShopLoginModel.fromJson(value.data);

     print(loginModel?.data?.email);
     emit(LoginSucess(loginModel!));
   }).catchError((error){
     print(error.toString());
     emit(LoginError(error.toString()));
   });
 }
 IconData suffix=Icons.visibility_outlined;
 bool ispass=true;
 void changevisibiality(){
    suffix=ispass? Icons.visibility_outlined:Icons.visibility_off_outlined;
    ispass= !ispass;
    emit(changevisiablity());
 }
}
