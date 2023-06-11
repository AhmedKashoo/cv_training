part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSucess extends LoginState {
 final  ShopLoginModel loginModel;

  LoginSucess(this.loginModel);
}
class LoginError extends LoginState {
  final String Error;

  LoginError(this.Error);

}
class changevisiablity extends LoginState{

}


