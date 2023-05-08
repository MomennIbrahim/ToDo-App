import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/state.dart';
import '../share/components.dart';
import '../share/local/cache_helper.dart';
import 'login/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = ToDoCubit.get(context).image;

    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 85.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 85.0,
                          backgroundColor: Colors.black12,
                          child: Container(
                            width: 160,
                            height: 160,
                            clipBehavior:
                            Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(100.0),
                            ),
                            child: image != null
                                ? Image.file(
                              File(image.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                                : SizedBox(
                              width: 100,
                              height: 100,
                              child: Image(
                                image: NetworkImage(
                                    '${ToDoCubit.get(context).userModel!.image}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          ToDoCubit.get(context).getProfileImage();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    ]),
                if(ToDoCubit.get(context).image != null)
                  defaultMaterialButton(onPressed: (){
                    ToDoCubit.get(context).uploadImage();
                  }, text: 'Upload'),
                if(state is UserUpdateLoadingState)
                  const LinearProgressIndicator(color: Colors.green),
                const SizedBox(height: 15.0,),
                Text(ToDoCubit.get(context).userModel!.name.toString(),style: const TextStyle(fontSize: 18.0)),
                const SizedBox(height: 15.0,),
                Text(ToDoCubit.get(context).userModel!.email.toString(),style: const TextStyle(fontSize: 18.0)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        CacheHelper.removeData(key: 'uId').then((value) {
                          navigateTo(context, LoginScreen());
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          width: 100.0,
                          height: 40.0,
                          child: const Center(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      } ,
    );
  }
}
