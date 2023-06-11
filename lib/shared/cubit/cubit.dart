import 'package:cv_training/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../Modules/ArchiveTasks/ArchiveTasks.dart';
import '../../Modules/DoneTasks/DoneTasks.dart';
import '../../Modules/NewTasks/NewTasks.dart';
import '../../Network/local/Cash_helper.dart';
import '../components/constant.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int current_index = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];
  List<Map>newtask=[];
  List<Map>donetask=[];
  List<Map>archivtask=[];
  List<String> titles = ["New Tasks", "Done Tasks", "Archive Tasks"];
  void changeIndex(int index){
    current_index=index;
    emit(ChangeBottomNavBarState());
  }
  Database? database;
  void createDataBase()  {
     openDatabase('tod.db', version: 1, onCreate: (database, version) {
      print("DataBase created");
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((error) {
        print("error when table created${error.toString()}");
      });
    }, onOpen: (database) {
      print("DataBase opened");
      getData(database);
    }).then((value) {
      database=value;
      emit(CreateDatabaseState());
     });
  }

   insertData({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$time","$date","DF")')
          .then((value) {
        print("$value DataInserted");
        emit(InsertDatabaseState());
        getData(database);
      }).catchError((error) {
        print("error when data insrerted${error.toString()}");
      });
    });
  }

  void getData(database)  {
    newtask=[];
    donetask=[];
    archivtask=[];
    emit(GetDatabaseLoadingState());
     database!.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element) {
         if(element['status']=='DF'){
           newtask.add(element);
         }else if(element['status']=='done'){
           donetask.add(element);
         }else if(element['status']=='archive'){
           archivtask.add(element);
         }

       });
      emit(GetDatabaseState());
      print(value);
    });
  }
  void updateData({required String status,required int id}){
     database!.rawUpdate (
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          emit(UpdateDatabaseState());
          getData(database);
     });
  }
  void DeleteData({required int id}){
    database!.rawDelete (
        'DELETE FROM tasks WHERE id = ?', [id],
       ).then((value) {
      emit(DeleteDatabaseState());
      getData(database);
    });
  }
  bool bottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheet({required bool isshow,required IconData icon}){
    bottomSheetShown =isshow;
    fabIcon=icon;
    emit(ChangeBottomSheetState());
  }
  bool isDark=false;
  ThemeMode mode=ThemeMode.dark;
  void changeMode({bool?fromshared}){
    if(fromshared !=null){
      isDark=fromshared;
      emit(ChangeMode());
    }else{
      isDark=!isDark;
      CashHelper.putdata(key:'isDark', value: isDark).then((value) {
        emit(ChangeMode());
      });
    }
    emit(ChangeMode());

  }

}