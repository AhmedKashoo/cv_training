import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (contex,state){
        var task=AppCubit.get(context).donetask;
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
