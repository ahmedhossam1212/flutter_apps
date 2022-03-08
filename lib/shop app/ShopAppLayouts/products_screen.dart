// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/shop%20app/cubitShopApp/cubit2.dart';
// import 'package:newsapp/shop%20app/cubitShopApp/states2.dart';
// import 'package:newsapp/shop%20app/models/Home_Model.dart';
// import '../models/categoris_model.dart';
//
//
//
// class ProductsScreen  extends StatelessWidget {
//   const ProductsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit,ShopStates>(
//         listener: (context, state) {
//
//         } ,
//       builder:   (context, state) {
//           return ConditionalBuilder(
//             condition: ShopCubit.get(context).homeModel !=null &&
//                 ShopCubit.get(context).categoriesModel != null ,
//             builder: (context)=> productsBuilder(
//                 ShopCubit.get(context).homeModel!,ShopCubit.get(context),context,index) ,
//             fallback: (context)=> Center(
//                 child: CircularProgressIndicator())  ,
//
//
//           );
//       }
//     );
//   }
//
//   Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel, context ) =>  SingleChildScrollView(
//     physics: BouncingScrollPhysics() ,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CarouselSlider(items: model!.data!.banners.map((e) =>
//             Image(image: NetworkImage("${e.image}"),
//           width: double.infinity ,
//           fit: BoxFit.cover,
//         ),).toList() ,
//             options: CarouselOptions(
//               height: 250.0,
//               initialPage: 0,
//               viewportFraction: 1.0,
//               enableInfiniteScroll: true,
//               reverse: false,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 5),
//               autoPlayAnimationDuration: Duration(seconds: 1),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               scrollDirection: Axis.horizontal,
//
//             ),
//         ),
//         SizedBox(height: 10.0),
//          Padding(
//            padding: const EdgeInsets.symmetric(
//              horizontal: 10.0,
//            ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                Text("Categories",
//                  style: TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.w800,
//                ),),
//                SizedBox(height: 10.0),
//         Container(
//                 height: 100.0,
//                 child: ListView.separated(
//                   physics: BouncingScrollPhysics(),
//                    scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => buildCategoryItem(categoriesModel!.data!.data[index]) ,
//                     separatorBuilder:(context, index) =>SizedBox(width: 10.0) ,
//                     itemCount: categoriesModel!.data!.data.length ),
//         ),
//                SizedBox(height: 20.0),
//         Text("New Products",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w800,
//                 ),),
//              ],
//            ),
//          ),
//         SizedBox(height: 10.0,),
//         Container( color: Colors.grey[300],
//           child: GridView.count(crossAxisCount: 2,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           mainAxisSpacing: 10.0,
//           crossAxisSpacing: 10.0,
//           childAspectRatio: 1/1.7,
//           children:List.generate( model.data!.products.length,
//                 (index)=> buildProduct(model.data!.products[index],context)  ,)
//           ),
//         )
//
//
//       ],
//     ),
//   );
//   Widget buildProduct(ProductModel model, context )=> Container(
//     color: Colors.white,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(  alignment: AlignmentDirectional.bottomStart,
//           children: [
//             Image(image: NetworkImage(model.image!),
//             width:double.infinity ,
//              height: 200.0,
//
//           ),
//           if (model.discount != 0)
//           Container( color: Colors.redAccent,
//             child:
//
//             Text("DISCOUNT ${model.discount.round()}%",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 15.0,
//               height: 1.3,
//             ),
//             ),
//           ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 model.name!,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   height: 1.3
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text("${model.price.round()} EGP",
//                     style: TextStyle(fontSize: 12.0,
//                       backgroundColor: Colors.green,
//                     ),),
//                   SizedBox(width: 10.0,),
//                   if(model.discount !=0)
//                   Text('${model.oldPrice.round()}',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey,
//                     decoration: TextDecoration.lineThrough,
//                   ),
//                   ),
//                  SizedBox(width: 10.0,),
//                   IconButton(
//                     padding: EdgeInsets.zero,
//                     onPressed: (){
//                       ShopCubit.get(context).changeFavorite(model.id);
//
//                     },
//                     icon: Icon(Icons.favorite,
//                      color: ShopCubit.get(context).favorites[model.id] ? Colors.red : Colors.grey,
//                      size: 11.0,
//                   ),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//
//     ),
//   );
//
//   Widget buildCategoryItem(DataModel model) =>  Stack(
//     alignment: AlignmentDirectional.bottomCenter,
//     children: [
//       Image(image: NetworkImage(model.image!),
//         width: 100.0,
//         height: 100.0,
//         fit: BoxFit.cover,
//
//       ),
//       Container(
//         color: Colors.black.withOpacity(.8),
//         width: 100.0,
//         child: Text(model.name!,
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             color: Colors.white,
//
//           )
//           ,),
//       ),
//     ],
//   );
// }
