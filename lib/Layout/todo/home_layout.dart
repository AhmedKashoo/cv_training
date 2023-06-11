import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:cv_training/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../Modules/ArchiveTasks/ArchiveTasks.dart';
import '../../Modules/DoneTasks/DoneTasks.dart';
import '../../Modules/NewTasks/NewTasks.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if(state is InsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.current_index]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.bottomSheetShown) {
                    if (formkey.currentState!.validate()) {
                     cubit.insertData(
                              title: titleController.text,
                              time: timeController.text,
                              date: dateController.text);

                    }
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet((context) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.grey[100],
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultFormField(
                                      label: 'task title',
                                      controller: titleController,
                                      type: TextInputType.text,
                                      prefix: Icons.title,
                                      validate: (String? v) {
                                        if (v!.isEmpty) {
                                          return 'Please Enter task Title';
                                        }
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DefaultFormField(
                                      label: 'task time',
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      prefix: Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          print(value?.format(context));
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      validate: (String? v) {
                                        if (v!.isEmpty) {
                                          return 'Please Enter task time';
                                        }
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DefaultFormField(
                                      label: 'task date',
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      prefix: Icons.calendar_today_outlined,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    "2024-08-01"))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMEd()
                                                  .format(value!)
                                                  .toString();
                                        });
                                      },
                                      validate: (String? v) {
                                        if (v!.isEmpty) {
                                          return 'Please Enter task date';
                                        }
                                      }),
                                ],
                              ),
                            ),
                          );
                        })
                        .closed
                        .then((value) {

                          cubit.changeBottomSheet(isshow: false, icon: Icons.edit);

                        });
                    cubit.changeBottomSheet(isshow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.current_index,
                onTap: (index) {

                    cubit.changeIndex(index);

                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_rounded), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archived")
                ],
              ),
              body: ConditionalBuilder(
                condition:state is! GetDatabaseLoadingState,
                fallback: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                },
                builder: (BuildContext context) {
                  return cubit.screens[cubit.current_index];
                },
              ));
        },
      ),
    );
  }
}
