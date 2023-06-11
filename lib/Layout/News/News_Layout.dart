import 'package:cv_training/Layout/News/cubit/cubit.dart';
import 'package:cv_training/Layout/News/cubit/state.dart';
import 'package:cv_training/Network/Remote/Dio.dart';
import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness()..getScience()..getSports(),
      child: BlocConsumer<NewsCubit,NewsState>(
        listener: (context ,state){},
        builder: (context ,state){
          var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "News App"
              ),
              actions: [
                IconButton(onPressed: (){

                }, icon: Icon(Icons.search),),
                IconButton(onPressed: (){
                  AppCubit.get(context).changeMode();
                }, icon: Icon(Icons.brightness_4_outlined))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.BottomNavItem,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },

      ),
    );
  }
}
