// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/componnents/componants.dart';
// import 'package:newsapp/componnents/constans.dart';
// import 'package:newsapp/news%20app/cubit.dart';
// import 'package:newsapp/news%20app/states.dart';
//
// class SearchScreent extends StatelessWidget {
//
//   var searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer <NewsCubit,NewsStates>(
//       listener: (context,state){},
//       builder: (context,state)
//       {
//         var list = NewsCubit.get(context).search;
//
//         return Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: defaultFormField(
//                   onChange: (value)
//                   {
//                     NewsCubit.get(context).getSearch(value);
//                   },
//                   controller: searchController,
//                   type: TextInputType.text,
//                   validate: (String value)
//                   {
//                     if (value.isEmpty)
//                     {
//                       return'search must not be empty';
//                     }
//                     return null;
//                   },
//                   label: 'Search',
//                   prefix: Icons.search,
//                 ),
//               ),
//               Expanded(child: articleBuilder(list, context,isSearch:true))
//             ],
//
//           ),
//         );
//       },
//
//     );
//   }
// }
