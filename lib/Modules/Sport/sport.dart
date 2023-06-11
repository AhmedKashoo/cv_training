import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Layout/News/cubit/cubit.dart';
import '../../Layout/News/cubit/state.dart';
import '../../shared/components/components.dart';

class Sport extends StatelessWidget {
  const Sport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          fallback: (BuildContext context) {return Center(child: CircularProgressIndicator());  },
          builder: (BuildContext context) {
            return ListView.separated(itemBuilder: (context,index)=> buildArticleItem(NewsCubit.get(context).sports[index],context),
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                ), itemCount: 10);
          },
          condition: state is!NewsLoadingState,


        );

      },

    );
  }
}
