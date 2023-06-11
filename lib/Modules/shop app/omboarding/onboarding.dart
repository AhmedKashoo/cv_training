import 'package:cv_training/Network/local/Cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../Shop login/shopLogin.dart';

class onboardingModel{
  final String image;
  final String title;
  final String body;

  onboardingModel(this.image, this.title, this.body);
}


class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void submit(){
    CashHelper.savedata(key: 'onboarding', value: true).then((value) {
      navigateAndFinish(context,shopLogin());



    });
  }

  var borderController=PageController();

  List<onboardingModel>onboardinglist=[
    onboardingModel('https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-260nw-1037719192.jpg', 'title1', 'body 1'),
    onboardingModel('https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-260nw-1037719192.jpg', 'title2', 'body 2'),
    onboardingModel('https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-260nw-1037719192.jpg', 'title3', 'body 3'),
  ];

  bool islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
submit();
          }, child: Text("Skip",style: TextStyle(color: Colors.deepOrange),))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: PageView.builder(
              controller: borderController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index){
                if(index==onboardinglist.length-1){
                  setState(() {
                    islast=true;
                    print("is lasssst");
                  });
                }else{
                  setState(() {
                    islast=false;
                  });
                }
              },
              itemBuilder: (context,index)=>buildItem(onboardinglist[index]),itemCount: onboardinglist.length,)),
            SizedBox(height: 40),
            Row(
              children: [
               SmoothPageIndicator(controller: borderController, count: onboardinglist.length,
                 effect: ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   dotHeight: 10,
                   dotWidth: 10,
                   spacing: 5,
                   expansionFactor: 4,
                   activeDotColor: Colors.deepOrange
                 ),
               ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(islast ==true){
                    submit();
                  }else{
                    borderController.nextPage(duration: Duration(
                        microseconds: 750
                    ), curve: Curves.bounceIn);
                  }

                },child: Icon(Icons.arrow_forward_ios),)
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildItem(onboardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: NetworkImage(model.image))),

      Text(model.title,style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
      ),),
      SizedBox(height: 15,),
      Text(model.body,style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold
      ),),
    ],
  );
}
