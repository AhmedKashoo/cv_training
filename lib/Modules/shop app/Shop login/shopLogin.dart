import 'package:cv_training/Layout/shop%20app/cubit/cubit.dart';
import 'package:cv_training/Network/local/Cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Layout/shop app/ShopLayOut.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constant.dart';
import '../Register/Register.dart';
import 'cubit/login_cubit.dart';

class shopLogin extends StatefulWidget {
  const shopLogin({Key? key}) : super(key: key);

  @override
  State<shopLogin> createState() => _shopLoginState();
}

class _shopLoginState extends State<shopLogin> {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if(state is LoginSucess){

           if( state.loginModel!.status!){
             print(state.loginModel.data?.name);
             CashHelper.savedata(key: "Token", value: state.loginModel.data!.token.toString()).then((value) {
               token=state.loginModel.data!.token;
               ShopCubit.get(context).GetUserData();
               ShopCubit.get(context).GetFavourite();
               ShopCubit.get(context).GetData();
               ShopCubit.get(context).Getcategories();

               navigateAndFinish(context, ShopLayout());
             });
             Fluttertoast.showToast(
                 msg: state.loginModel.message.toString(),
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.BOTTOM,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.green,
                 textColor: Colors.white,
                 fontSize: 16.0
             );

           }else  {
             Fluttertoast.showToast(
                 msg: state.loginModel.message.toString(),
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.BOTTOM,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.red,
                 textColor: Colors.white,
                 fontSize: 16.0
             );


           }


          }
        },
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black,)),
                        SizedBox(height: 10,),
                        Text("login now to browse our hot offers",style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 25,),
                        DefaultFormField(controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String ?value){
                              if(value!.isEmpty){
                                return 'please enter your email';
                              }
                            },
                            label: "Email",
                            prefix: Icons.email_outlined),
                        SizedBox(height: 15,),
                        DefaultFormField(controller: passswordController,
                            suffixPressed: (){
                              LoginCubit.get(context).changevisibiality();
                            },
                            isPassword: LoginCubit.get(context).ispass,
                            suffix: LoginCubit.get(context).suffix,
                            type: TextInputType.visiblePassword,
                            validate: (String ?value){
                              if(value!.isEmpty){
                                return 'please enter your password';
                              }
                            },
                            label: "Password",
                            prefix: Icons.lock_outline),
                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is!LoginLoading,
                          builder: (context)=>defaultButton(function: (){
                            if(formkey.currentState!.validate()){
                              LoginCubit.get(context).UserLogin(email: emailController.text, password: passswordController.text);

                            }
                          }, text: "LOGIN"),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account ?"),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopRegister()));
                            }, child: Text("REGISTER NOW",style: TextStyle(color: Colors.deepOrange),))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
