import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/cubit.dart';

navigateAndFinish(context, screen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

navigateTo(context, screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

Widget defaultTextFormField(
    {@required Function validate,
    bool isObscure = false,
    @required TextEditingController textEditingController,
    Function onSaved,
    @required String label,
    @required TextInputType keyboardType,
    IconData prefix,
    IconData suffixIcon,
    Function suffixpressed,
    Function onSubmitted}) {
  return TextFormField(
    onFieldSubmitted: onSubmitted,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        suffixIcon:
            IconButton(onPressed: suffixpressed, icon: Icon(suffixIcon)),
        prefixIcon: Icon(prefix),
        label: Text(label),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2))),
    obscureText: isObscure,
    controller: textEditingController,
    validator: validate,
    onSaved: onSaved,
  );
}

Widget defaultButton({
  Color color = Colors.blue,
  @required Function onpressed,
  @required String text,
  double width = double.infinity,
  double redius = 0.0,
  bool isUpper = true,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(redius)),
    child: MaterialButton(
      child: Text(isUpper ? text.toUpperCase() : text.toLowerCase()),
      onPressed: onpressed,
    ),
  );
}

defaultTextButton(
    {@required Function onpressed, @required String text, Color color}) {
  return MaterialButton(
    child: Text(
      text.toUpperCase(),
      style: TextStyle(color: color),
    ),
    onPressed: onpressed,
  );
}

showToast({@required message, @required state}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      child: Row(
        //  mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Image(
              image: NetworkImage("${model.image}"),
              height: 150,
              width: 200,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.red,
                child: Text(
                  'Discount',
                  style: TextStyle(color: Colors.white),
                ),
              )
          ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    Spacer(),
                    Row(children: [
                      Text('${model.price}'),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text('${model.oldPrice}',
                            style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey)),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopHomeCubit.get(context)
                                .changeFavorites(model.id);
                            // print(model.id);
                          },
                          icon: CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  ShopHomeCubit.get(context).Favorites[model.id]
                                      ? Colors.orange
                                      : Colors.grey,
                              child: Icon(Icons.favorite_border_outlined))),
                    ])
                  ]),
            ),
          )
        ],
      ),
    );
