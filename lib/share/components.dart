import 'package:flutter/material.dart';

import '../layout/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyBoardTyp,
  required context,
  required String text,
  Icon? prefixIcon,
  required Function onSubmitted,
  String? validateText,
  IconButton? suffixIcon,
  bool obscure = false,
  int maxLines = 1
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    obscureText: obscure,
    keyboardType: keyBoardTyp,
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.0)),
        hintText: text,
        filled: true,
        fillColor: Colors.black12,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        iconColor: Theme.of(context).primaryColor),
    onFieldSubmitted: (value) {
      onSubmitted;
    },
    validator: (value) {
      if (value!.isEmpty) {
        return validateText;
      }
      return null;
    },
  );
}

Widget defaultMaterialButton({
  context,
  required Function onPressed,
  required String text,
  double high = 40,
  double width = 150,
  Color color1 = Colors.green,
  Color color2 = Colors.lightGreen,
  Color textColor = Colors.white,
  bool isUpperCase = false,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
      child: Container(
        width: width,
        height: high,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color1, color2]),
        ),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(color: textColor, fontSize: 16.0),
          ),
        ),
      ),
    ),
  );
}

defaultText(
    {required String text,
      double size = 18.0,
      fontWeight,
      double letterSpacing = 0.0,
      Color color = Colors.black,
      isUpperCase = false}) {
  return Text(
    isUpperCase ? text.toUpperCase() : text,
    style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color),
  );
}

defaultTextButton(
    {required Function onPressed,
      required String text,
      fontWeight,
      double? size,
      bool isUpperCase = false}) {
  return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(fontWeight: fontWeight, fontSize: size)));
}

navigateTo(context, Widget widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndReplace(context, Widget widget) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndFinish(context, widget) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

errorSnackBar({context,text,Function? function}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    action: SnackBarAction(label: 'Ops :(',textColor: Colors.white, onPressed: () {
      function!();
    }),
  ));
}

successSnackBar({context,text,Function? function}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.green,
    action: SnackBarAction(label: 'Great!',textColor: Colors.white, onPressed: () {
      function!();
    }),
  ));
}

requestFocus(context){
  return FocusScope.of(context).requestFocus(FocusNode());
}

Widget buildBottomSheet({context, controller, function, icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    child: Column(
      children: [
        defaultTextFormField(
            controller: controller,
            keyBoardTyp: TextInputType.text,
            context: context,
            text: 'Name of task',
            onSubmitted: () {}),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green, borderRadius: BorderRadius.circular(20.0)),
                      child: IconButton(
                          onPressed: () {
                            ToDoCubit.get(context).selectDate(context);
                          },
                          icon: const Icon(
                            Icons.date_range_outlined,
                            color: Colors.white,
                          ))
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Select Date')
                ],
              ),
            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green, borderRadius: BorderRadius.circular(20.0)),
                      child: IconButton(
                          onPressed: () {
                            ToDoCubit.get(context).selectTime(context);
                          },
                          icon: const Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ))
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Select Time')
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        FloatingActionButton(
          tooltip: 'Add',
          onPressed: () {
           function();
          },
          child: Icon(icon),
        ),
      ],
    ),
  );
}

// ToDoCubit.get(context).createToDO(
// title: controller.text,
// time: ToDoCubit.get(context).selectedTime.format(context).toString(),
// dateTime: ToDoCubit.get(context).selectedDate.toString());
// controller.text = '';
// Navigator.of(context).pop();


