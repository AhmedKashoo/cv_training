import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Layout/shop app/ShopLayOut.dart';
import '../../../Network/local/Cash_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constant.dart';
import '../Shop login/cubit/login_cubit.dart';
import 'cubit/login_cubit.dart';

class ShopRegister extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passswordController=TextEditingController();
  var NameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state){
          if(state is RegisterSucess){

            if( state.loginModel!.status!){
              print(state.loginModel.data?.name);
              CashHelper.savedata(key: "Token", value: state.loginModel.data!.token.toString()).then((value) {
                token=state.loginModel.data!.token;
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
          return Scaffold(
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
                        Text("REGISTER",style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black,)),
                        SizedBox(height: 10,),
                        Text("register now to browse our hot offers",style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
                             RegisterCubit.get(context).changevisibiality();
                            },
                            isPassword:RegisterCubit.get(context).ispass,
                            suffix:RegisterCubit.get(context).suffix,
                            type: TextInputType.visiblePassword,
                            validate: (String ?value){
                              if(value!.isEmpty){
                                return 'please enter your password';
                              }
                            },
                            label: "Password",
                            prefix: Icons.lock_outline),
                        SizedBox(height: 15,),
                        DefaultFormField(controller: NameController,

                            type: TextInputType.name,
                            validate: (String ?value){
                              if(value!.isEmpty){
                                return 'please enter your Name';
                              }
                            },
                            label: "Password",
                            prefix: Icons.person),
                        SizedBox(height: 15,),
                        DefaultFormField(controller: phoneController,

                            type: TextInputType.phone,
                            validate: (String ?value){
                              if(value!.isEmpty){
                                return 'please enter your Phone';
                              }
                            },
                            label: "Phone",
                            prefix: Icons.phone),
                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is !RegisterLoading,
                          builder: (context)=>defaultButton(function: (){
                            if(formkey.currentState!.validate()){
                             RegisterCubit.get(context).UserRegister(email: emailController.text, password: passswordController.text, name: NameController.text, phone: phoneController.text);

                            }
                          }, text: "Register"),
                          fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
                        ),
                        SizedBox(height: 15,),


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
