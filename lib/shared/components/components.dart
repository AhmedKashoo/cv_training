import 'package:cv_training/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../Layout/shop app/cubit/cubit.dart';

Widget DefaultFormField(
    {required TextEditingController controller,
      required TextInputType type,
      void Function(String)? onSubmit,
      void Function(String)? onChange,
      void Function()? onTap,
      bool isPassword = false,
      required String? Function(String?)? validate,
      required String label,
      required IconData prefix,
      IconData? suffix,
      void Function()? suffixPressed,
      bool isClickable = true,
      void Function(String)? onPressed}
    )=>TextFormField(
  style: TextStyle(),
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,

    ),
    suffixIcon: suffix != null
        ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    )
        : null,
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
Widget buildTaskItem(Map model,context){
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (dirction){
      AppCubit.get(context).DeleteData(id: model['id']);

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text("${model['date']}"),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model['title']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${model['time']}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(onPressed: (){
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
              icon: Icon(Icons.check_circle_outline,color: Colors.green,),
          ),
          IconButton(onPressed: (){
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
            icon: Icon(Icons.archive_outlined,color: Colors.grey,),
          ),
        ],
      ),
    ),
  );
}
Widget buildArticleItem(article,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('${article['urlToImage']}'),
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodyText1
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildProductItems( model, context,{bool inSearch=true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0&&inSearch)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0&&inSearch)
                    Text(model.discount.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),

                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavourite(
                          (model.id)!
                      );
                       print(model.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopCubit
                            .get(context)
                            .favourite[model.id]!
                            ? Colors.deepOrange
                            : Colors.grey,
                        radius: 15,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);