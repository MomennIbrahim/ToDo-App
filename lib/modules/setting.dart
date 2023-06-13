import 'dart:io';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/state.dart';
import 'package:to_do_app/modules/login/login_screen.dart';
import '../share/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = ToDoCubit.get(context).image;

    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {
        if (state is RemoveTokenSuccessState) {
          navigateTo(context, LoginScreen());
          ToDoCubit.get(context).currentIndex = 0;
        }
        if (state is UploadImageSuccessState) {
          successSnackBar(context: context, text: 'Uploaded successfully');
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BuildCondition(
              condition: ToDoCubit.get(context).userModel != null,
              builder: (context) => Column(
                children: [
                  Stack(alignment: Alignment.bottomRight, children: [
                    CircleAvatar(
                      radius: 85.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 85.0,
                        backgroundColor: Colors.black12,
                        child: Container(
                          width: 160,
                          height: 160,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
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
                      onTap: () {
                        ToDoCubit.get(context).getProfileImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: ToDoCubit.get(context).isDark
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  ]),
                  if (state is PickedImageSuccessState)
                    defaultMaterialButton(
                        onPressed: () {
                          ToDoCubit.get(context).uploadImage();
                        },
                        text: ToDoCubit.get(context).isLang == false
                            ? 'Upload'
                            : 'رفع الصورة'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is UploadImageLoadingState)
                    const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    )),
                  if (state is UserUpdateLoadingState)
                    const LinearProgressIndicator(color: Colors.green),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(ToDoCubit.get(context).userModel!.name.toString(),
                      style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(ToDoCubit.get(context).userModel!.email.toString(),
                      style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('أختر اللغة'),
                              elevation: 5.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              content: Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      ToDoCubit.get(context).changeEnLang();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: const Text(
                                          'الأنجليزية',
                                          textAlign: TextAlign.center,
                                        )),
                                  )),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      ToDoCubit.get(context).changeArLang();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: const Text('العربية',
                                          textAlign: TextAlign.center),
                                    ),
                                  )),
                                ],
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(15.0)),
                          width: ToDoCubit.get(context).isLang == false
                              ? 180.0
                              : 120.0,
                          height: 40.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ToDoCubit.get(context).isLang == false
                                    ? 'Change Language'
                                    : 'تـغير اللغة',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          ToDoCubit.get(context).changeMode();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 120.0,
                          height: 40.0,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                ToDoCubit.get(context).isDark
                                    ? ToDoCubit.get(context).isLang
                                        ? 'وضع الضوء'
                                        : 'Light Mode'
                                    : ToDoCubit.get(context).isLang
                                        ? 'الوضع المظلم'
                                        : 'Dark Mode',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          ToDoCubit.get(context).removeToken();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(15.0)),
                            width: 120.0,
                            height: 40.0,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  ToDoCubit.get(context).isLang == false
                                      ? 'Logout'
                                      : 'تسجيل الخروج',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
