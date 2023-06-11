import 'package:cv_training/Layout/shop%20app/cubit/cubit.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/Models/ShopApp/CategoriesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class cateogries_Screen extends StatelessWidget {
  const cateogries_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          return ListView.separated(itemBuilder: (context ,index)=>BuildCatItem(ShopCubit.get(context).categoriesModel!.data!.data![index]),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length);
        },
        listener: (context,state){});
  }
  Widget BuildCatItem(DataModel ? model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model!.image.toString()),width: 100,height: 100,fit: BoxFit.cover,),
        SizedBox(width: 20,),
        Text(model.name.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
