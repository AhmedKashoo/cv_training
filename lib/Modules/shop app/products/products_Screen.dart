import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cv_training/Layout/shop%20app/cubit/states.dart';
import 'package:cv_training/Models/ShopApp/HomeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Layout/shop app/cubit/cubit.dart';
import '../../../Models/ShopApp/CategoriesModel.dart';

class Product_Screen extends StatelessWidget {
  const Product_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavouriteState){

          if(!state.changeFavouriteModel.status!){
            Fluttertoast.showToast(
                msg: state.changeFavouriteModel.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepOrange,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel !=null &&ShopCubit.get(context).categoriesModel !=null,
          builder: (context)=>ProductBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget ProductBuilder(HomeModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:model?.data?.banners?.map((e) => Image(
            image: NetworkImage(e.image.toString()),
            width: double.infinity,
            fit: BoxFit.fill,
          ),).toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: Duration(seconds: 1),
            scrollDirection: Axis.horizontal
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (cotext,index)=>BildCotegroiesItem(categoriesModel!.data!.data![index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount: categoriesModel!.data!.data!.length),
              ),
              SizedBox(height: 20,),
              Text("New Products",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
            ],
          ),
        ),


        GridView.count(
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.57,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(model!.data!.products!.length ,(index) => BuildGridProduct(model!.data!.products![index],context)),

        ),

      ],
    ),
  );
  Widget BuildGridProduct(Products model,context)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
        Image(image: NetworkImage(model.image.toString()),width: double.infinity,height: 170,),
          if(model.discount !=0)  Container(
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
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                fontSize: 14,
                height: 1.3
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${model.price.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: Colors.deepOrange
                ),),
                SizedBox(width: 5,),
                if(model.discount !=0)Text("${model.oldPrice.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
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
  );
  Widget BildCotegroiesItem(DataModel data)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(data.image.toString()),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(color: Colors.black.withOpacity(.6),
        width: 100,
        child: Text("${data.name}",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
      )
    ],
  );
}
