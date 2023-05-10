import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/layout_screen.dart';
import 'package:to_do_app/layout/state.dart';
import 'package:to_do_app/modules/login/login_screen.dart';
import 'package:to_do_app/share/bloc_observe.dart';
import 'package:to_do_app/share/const.dart';
import 'package:to_do_app/share/local/cache_helper.dart';
import 'share/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  // print(uId);


  if(uId != null){
    widget = const LayoutScreen();
  }else{
    widget = LoginScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.startWidget}) : super(key: key);
  final  startWidget ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ToDoCubit()..getUserData()..getTodoList(),
      child: BlocConsumer<ToDoCubit,ToDoStates>(
        listener:(context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: GoogleFonts.aBeeZee().fontFamily,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
