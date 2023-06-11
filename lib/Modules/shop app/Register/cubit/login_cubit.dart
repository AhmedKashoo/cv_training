import 'package:bloc/bloc.dart';
import 'package:cv_training/shared/components/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';


import '../../../../Models/ShopApp/ShopLoginModel.dart';
import '../../../../Network/Remote/Shop Dio/dio.dart';

part 'login_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
   ShopLoginModel? loginModel;
  RegisterCubit() : super(RegisterInitial());
 static RegisterCubit get(context)=>BlocProvider.of(context);
 void UserRegister({required String email,required String password,required String name,required String phone}){
   emit(RegisterLoading());
   ShopDioHelper.postData(url: "https://student.valuxapps.com/api/register", data: {
     "email": email,
     "password":password,
     "name":name,
     "phone":phone
   }).then((value) {
     loginModel=ShopLoginModel.fromJson(value.data);

     print(loginModel?.data?.email);
     emit(RegisterSucess(loginModel!));
   }).catchError((error){
     print(error.toString());
     emit(RegisterError(error.toString()));
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
