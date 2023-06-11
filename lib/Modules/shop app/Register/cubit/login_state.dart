part of 'login_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSucess extends RegisterState {
 final  ShopLoginModel loginModel;

  RegisterSucess(this.loginModel);
}
class RegisterError extends RegisterState {
  final String Error;

  RegisterError(this.Error);

}
class changevisiablity extends RegisterState{

}


