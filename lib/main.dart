import 'package:bloc/bloc.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/Network/local/Cash_helper.dart';
import 'package:cv_training/shared/components/bloc_observer.dart';
import 'package:cv_training/shared/components/constant.dart';
import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:cv_training/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Layout/News/News_Layout.dart';
import 'Layout/shop app/ShopLayOut.dart';
import 'Layout/shop app/cubit/cubit.dart';
import 'Layout/todo/home_layout.dart';
import 'Modules/shop app/Shop login/shopLogin.dart';
import 'Modules/shop app/omboarding/onboarding.dart';
import 'Network/Remote/Dio.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CashHelper.init();
 Widget widget;
 bool? isDark=CashHelper.getdata(key: 'isDark');
 bool? onboarding=CashHelper.get(key: 'onboarding');
 token=CashHelper.get(key: "Token");
  print(token);

  if(onboarding !=null){
   if(token != null) widget=ShopLayout();
   else widget=shopLogin();

 }else {
   widget=Onboarding();
 }
 print(onboarding);
  runApp( MyApp(  isDark,widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWeidget;

   MyApp( this.isDark, this.startWeidget);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
        BlocProvider(
        create: (BuildContext context)=>AppCubit()..changeMode(fromshared: isDark)),
      BlocProvider(
          create: (BuildContext context)=>ShopCubit()..GetData()..Getcategories()..GetFavourite()..GetUserData()),

    ],

      child: BlocConsumer<AppCubit,AppState>(
        listener: (contex,index){},
        builder: (context,index){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),


            ),

            darkTheme: ThemeData(
              scaffoldBackgroundColor:HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: ThemeMode.light,
            home: Directionality(

                textDirection: TextDirection.ltr,
                child: startWeidget!
          ),
          );
        },

      ),
    );
  }
}
