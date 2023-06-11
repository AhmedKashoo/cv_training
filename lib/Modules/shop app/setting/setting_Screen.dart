import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cv_training/Layout/shop%20app/cubit/cubit.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/shared/components/components.dart';
import 'package:cv_training/shared/components/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){
        if(state is ShopSuccessUpdateState){
        //  showToast(text: 'User Information Updated Successfully ',
          //    state: ToastState.Success
          //);
        }
        if(state is ShopErrorUpdateState){
       //  showToast(text: 'User Information don\'t Updated',
         //     state: ToastState.Success
          //);
        }
      } ,
      builder:(context,state){
        var model=ShopCubit.get(context).userdata;
        if(model !=null){
          nameController.text=model.data!.name !;
          phoneController.text=model.data!.phone!;
          emailController.text=model.data!.email!;
          print(nameController.text+' new one 2');
        }
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userdata !=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,),
                  DefaultFormField(
                      onTap: (){},


                      controller: nameController,
                      type: TextInputType.name,
                      validate: ( value){
                        if(value!.isEmpty)
                        {
                          return 'Name Cant be Empty';
                        }else return null;

                      },
                      label: 'Name',
                      prefix: Icons.person
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                      onTap: (){},

                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: ( value){
                        if(value!.isEmpty)
                        {
                          return 'emailAddress Cant be Empty';
                        }else return null;

                      },
                      label: 'Email',
                      prefix: Icons.email
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                      onTap: (){},

                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: ( value){
                        if(value!.isEmpty)
                        {
                          return 'phone Cant be Empty';
                        }else return null;

                      },
                      label: 'phone',
                      prefix: Icons.phone
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(function: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      ShopCubit.get(context).UodateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                      print(nameController.text+' new one');
                    }
                  },
                      text: 'Update'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(function: (){
                    ShopCubit.get(context).current_Index=0;
                    signOut(context);
                  }, text: 'Logout'),

                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }
}