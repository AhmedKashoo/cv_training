import 'package:cv_training/Layout/shop%20app/cubit/cubit.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/Network/local/Cash_helper.dart';
import 'package:cv_training/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Modules/shop app/Shop login/shopLogin.dart';
import '../../Modules/shop app/search/search_Screen.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,


            title: Text("Salla"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              }, icon: Icon(Icons.search),)

            ],
          ),
          body: cubit.Bottom_Screeen[cubit.current_Index],
          bottomNavigationBar: BottomNavigationBar(onTap:(index){
            cubit.changNavIndex(index);
          },
            elevation: 0,
            currentIndex: cubit.current_Index,
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.apps),
                label: "Cateogries"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.favorite),
                label: "Favourite"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.settings),
                label: "Settings"
            )
          ],
            
          ),

        );
      },

    );
  }
}
