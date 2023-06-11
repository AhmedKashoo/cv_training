import 'package:cv_training/shared/components/components.dart';
import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:cv_training/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constant.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (contex,state){
        var task=AppCubit.get(context).newtask;
        return ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(task[index],context),
            separatorBuilder:  (context,index)=>Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1,
            ),
            itemCount: task.length);
      },

    );
  }
}
