import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cv_training/Layout/News/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/News/cubit/cubit.dart';
import '../../shared/components/components.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
       return ConditionalBuilder(
          fallback: (BuildContext context) {return Center(child: CircularProgressIndicator());  },
          builder: (BuildContext context) {
            return ListView.separated(itemBuilder: (context,index)=> buildArticleItem(NewsCubit.get(context).business[index],context),
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                ), itemCount: NewsCubit.get(context).business.length);
          },
          condition: state is!NewsLoadingState,


        );

      },

    );
  }
}
