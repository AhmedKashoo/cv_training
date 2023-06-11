import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cv_training/Models/ShopApp/FavouriteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Layout/shop app/cubit/cubit.dart';
import '../../../Layout/shop app/cubit/states.dart';
import '../../../shared/components/components.dart';

class favourite_Screen extends StatelessWidget {
  const favourite_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          return ConditionalBuilder(condition:  state is ! ShopLoadingGetFavoritesState, builder: (BuildContext context) {
           return ListView.separated(itemBuilder: (context ,index)=>buildProductItems(ShopCubit.get(context).favouriteModel!.data!.data[index].product, context),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount: ShopCubit.get(context).favouriteModel!.data!.data!.length.toInt());

          }, fallback:  (context) => Center(child: CircularProgressIndicator()),

          );

        },
        listener: (context,state){});
  }
 /* Widget BuildFavItem(FavData model,context)=>Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.product!.image.toString()),width: double.infinity,height: 170,),
            if(model.product!.discount !=0)  Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
              color: Colors.red,
              child: Text(
                "DISCOUNT",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                ),
              ),
            ),
          ],),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.product!.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                  fontSize: 14,
                  height: 1.3
              ),),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${model.product!.price?.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: Colors.deepOrange
                  ),),
                  SizedBox(width: 5,),
                  if(model.product!.discount !=0)Text("${model.product!.oldPrice?.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                  ),),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        ShopCubit.get(context).changeFavourite(model.id!.toInt());
                      }, icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favourite[model.id!.toInt()] !? Colors.deepOrange:Colors.grey,
                      radius: 15.0,
                      child: Icon(Icons.favorite_border,size: 17,color: Colors.white,)))
                ],
              )
            ],
          ),
        ),

      ],
    ),
  );

  */
}
