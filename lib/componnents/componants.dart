
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/todo%20app/appCubit.dart';

import '../shop app/cubitShopApp/cubit2.dart';


Widget defaultButton({
double width = double.infinity,
Color background = Colors.blue,
bool isUpperCase = true,
double radius = 3.0,
required Function function,
required String text,
}) =>
Container(
width: width,
height: 40.0,
child: MaterialButton(
onPressed: (){function();},
child: Text(
isUpperCase ? text.toUpperCase() : text,
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

Widget defaultTextButton({
    required function,
    required String text,
}) => TextButton(onPressed: function , child: Text(text.toUpperCase())) ;

Widget defaultFormField({
required TextEditingController controller,
required TextInputType type,
Function ?onSubmit,
Function ?onChange,
Function ?onTap,
bool isPassword = false,
required Function validate,
required String label,
required IconData prefix,
IconData ?suffix,
Function ?suffixPressed,
bool isClickable = true,
}) =>
TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword,
enabled: isClickable,
onFieldSubmitted: (s){ onSubmit!(s); },
onChanged: (s){ onChange!(s); },
onTap: (){ onTap!();},
validator: (String? s) { return validate(s);},
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
prefix,
),
suffixIcon: suffix != null
? IconButton(
onPressed: (){suffixPressed!();},
icon: Icon(
suffix,
),
)
    : null,
border: OutlineInputBorder(),
),
);

Widget buildTaskItem(Map model, context) => Dismissible(
key: Key(model['id'].toString()),
child: Padding(
padding: const EdgeInsets.all(20.0),
child: Row(
children: [
CircleAvatar(
radius: 40.0,
child: Text(
'${model['time']}',
),
),
SizedBox(
width: 20.0,
),
Expanded(
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'${model['title']}',
style: TextStyle(
fontSize: 18.0,
fontWeight: FontWeight.bold,
),
),
Text(
'${model['date']}',
style: TextStyle(
color: Colors.grey,
),
),
],
),
),
SizedBox(
width: 20.0,
),
IconButton(
onPressed: ()
{
AppCubit.get(context).updateData(
status: 'done',
id: model['id'],
);
},
icon: Icon(
Icons.check_box,
color: Colors.green,
),
),
IconButton(
onPressed: () {
AppCubit.get(context).updateData(
status: 'archive',
id: model['id'],
);
},
icon: Icon(
Icons.archive,
color: Colors.black45,
),
),
],
),
),
onDismissed: (direction)
{
AppCubit.get(context).deleteData(id: model['id'],);
},
);

Widget tasksBuilder({
required List<Map> tasks,
}) => ConditionalBuilder(
condition: tasks.length > 0,
builder: (context) => ListView.separated(
itemBuilder: (context, index)
{
return buildTaskItem(tasks[index], context);
},
separatorBuilder: (context, index) => Padding(
padding: const EdgeInsetsDirectional.only(
start: 20.0,
),
child: Container(
width: double.infinity,
height: 1.0,
color: Colors.grey[300],
),
),
itemCount: tasks.length,
),
fallback: (context) => Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.menu,
size: 100.0,
color: Colors.grey,
),
Text(
'No Tasks Yet, Please Add Some Tasks',
style: TextStyle(
fontSize: 16.0,
fontWeight: FontWeight.bold,
color: Colors.grey,
),
),
],
),
),
);

void navigateTo (context,widget)=> Navigator.push(context,
    MaterialPageRoute(builder: (context)=>widget,
    ),
);

void showToast({
    required String text,
    required ToastState state,

}) =>
    Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,


);
enum ToastState { Success , Error , Warning  }

Color chooseToastColor(ToastState state)
{ Color color;
switch(state)
    {
    case ToastState.Success:
     color= Colors.green;
break;
    case ToastState.Error:
        color = Colors.red;
        break;
    case ToastState.Warning:
        color = Colors.amber;
        break;


}
return color ;



}


void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
    (context)=>widget),
        (route) {
            return false;
        });


Widget buildListProductScreen ( model,context)=>   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
        height: 120.0,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Stack(  alignment: AlignmentDirectional.bottomStart,
                    children: [
                        Image(image: NetworkImage(model.image!),
                            width:120.0 ,
                            height: 120.0,

                        ),
                        if (model.discount != 0)
                            Container( color: Colors.redAccent,
                                child:

                                Text("Discount ${model.discount}%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        height: 1.3,
                                    ),
                                ),
                            ),
                    ],
                ),
                SizedBox(
                    width: 20.0,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                model.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    height: 1.3
                                ),
                            ),
                            Spacer(),
                            Row(
                                children: [
                                    Text(
                                        '   ${model.price.toString()} EGP',
                                        style: TextStyle(fontSize: 12.0,
                                            backgroundColor: Colors.green,
                                        ),),
                                    SizedBox(width: 10.0,),
                                    if(model.discount !=0)
                                        Text(model.oldPrice.toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                                decoration: TextDecoration.lineThrough,
                                            ),
                                        ),
                                    SizedBox(width: 10.0,),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: (){
                                            ShopCubit.get(context).changeFavorite(model.id);

                                        },
                                        icon: Icon(Icons.favorite,
                                            color: ShopCubit.get(context).favorites[model.id]? Colors.red : Colors.grey ,
                                            size: 11.0,
                                        ),
                                    ),

                                ],
                            ),
                        ],
                    ),
                )
            ],

        ),
    ),
);