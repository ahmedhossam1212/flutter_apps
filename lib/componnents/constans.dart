// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//https://newsapi.org/v2/everything?q=tesla&&apiKey=65f7ff556ec76449fa7dc7c0069f040ca

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/componnents/componants.dart';
import 'package:newsapp/network/local/cash-helper.dart';
import 'package:newsapp/shop%20app/ShopAppLayouts/shop%20login.dart';
import 'package:newsapp/webView/web-view.dart';



Widget buildArticleItem(article,context ) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(



    padding: const EdgeInsets.all(20.0),



    child: Row(



      children: [



        Container(



          width: 120.0,



          height: 120.0,



          decoration: BoxDecoration(



              borderRadius: BorderRadius.circular(10),



              image: DecorationImage(



                image: NetworkImage('${article['urlToImage']}'),



                fit: BoxFit.cover,



              )



          ),











        ),



        SizedBox(width:20.0 ,),



        Expanded(



          child: Container(



            height: 120.0,



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,



              mainAxisAlignment: MainAxisAlignment.start,



              children:



              [



                Expanded(



                  child: Text("${article['title']}",



                    style: Theme.of(context).textTheme.bodyText1,



                    maxLines: 3,



                    overflow: TextOverflow.ellipsis,



                  ),



                ),



                SizedBox(height: 10.0,),



                Text("${article['publishedAt']}",



                  style: TextStyle(



                    color: Colors.grey,







                  ),







                )







              ],



            ),



          ),



        )



      ],



    ),



  ),
);


Widget articleBuilder(list,context,{isSearch=false}) => ConditionalBuilder(
    condition: list. length >0 ,
    builder: (context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=> buildArticleItem(list[index],context) ,
      separatorBuilder:(context,index)=> Container( color:Colors.grey ,
        height: 1.0,
        width: double.infinity,
      ) ,
      itemCount: 10,) ,
    fallback: (context)=> isSearch ?Container() : Center(child: CircularProgressIndicator())
);
void signOut(context)
{

  CacheHelper.removeData(key:'token').then((value)
  { if(value)
  {
    navigateAndFinish(context, LoginScreenShop(),);
  }
});
}

dynamic token= "";

dynamic uId= "";
