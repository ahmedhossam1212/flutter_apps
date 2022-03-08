import 'package:flutter/material.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/shop%20app/ShopAppLayouts/shop%20login.dart';

import 'package:newsapp/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
   required this.title,
   required this.image,
   required this.body ,
  });
}


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List <BoardingModel> boarding =
  [
    BoardingModel (
      image: "https://thumbs.dreamstime.com/b/family-shopping-taxi-service-flat-cartoon-happy-shop-mall-mother-father-kids-standing-bags-taking-parents-148326831.jpg ",
      title: "YOU ARE WELCOME..",
      body: "ShopApp" ,
    ),
    BoardingModel (
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0vuOpnc07by7Tvl3p4AlbUZ25EgYu8M7TpjRNNytfFqzAoq1TOerVdQErnnqYLCDR2tc&usqp=CAU ",
      title: "Everything you need is HERE",
      body: "ShopApp" ,
    ),
    BoardingModel (
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbELr8ic5arPS1m2V8sBatC_GYqcoddVm_cw&usqp=CAU ",
      title: " Excellent service  ",
      body: "ShopApp" ,
    ),
  ];
  bool isLast= false;

  void submit ()
  {
    CacheHelper.saveData(key: "onBoarding", value: true,).then((value)
    { if (value)
      {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>LoginScreenShop()) ,
                (route) => false

      );
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: 
      [
       defaultTextButton( function: submit,
       text: "SKIP")
      ],
      ),
      body: Column(
        children:
        [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller:boardController,
              onPageChanged: (int index)
              {
                if (index == boarding.length-1 )
                  {
                    setState(() {
                      isLast=true;
                    });
                  }else
                    {
                      setState(() {
                        isLast=false;
                      });
                    }
              },
              itemBuilder: (context ,index)=> buildBoardingItem(boarding[index]),
              itemCount: boarding.length,

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children:
              [  SmoothPageIndicator(controller: boardController,
                count: boarding.length,
                effect:ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                  activeDotColor: defaultColor,

                ) ,


              ),
             Spacer(),
             FloatingActionButton(onPressed: ()
             {
               if (isLast)
               {
                 submit();
               } else
                 {
                   boardController.nextPage(duration: Duration(milliseconds: 750),
                       curve: Curves.fastLinearToSlowEaseIn);
                  }

             },
               child: Icon(Icons.arrow_forward_ios) , )

              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    children: [
      Image(image:
      NetworkImage("${model.image} ")),

      SizedBox(height: 100.0,),
      Text("${model.title} " ,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,

        ) ,),
      SizedBox(height: 50.0,),
      Text(" ${model.body} " ,
        style: TextStyle(

          fontSize: 20.0,

        ) ,),
    ],
  );


}
