import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/layout/state.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/share/const.dart';
import 'package:to_do_app/share/local/cache_helper.dart';
import '../model/user_model.dart';
import '../modules/setting.dart';
import '../modules/add_task.dart';
import '../modules/task.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(InitialToDoState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const TaskScreen(),
    const DoneScreen(),
    const SettingScreen(),
  ];

  List<String> enTitles = [
    'Tasks',
    'Add New Task',
    'Setting',
  ];
  List<String> arTitles = [
    'المهام',
    'أضف مهام جديدة',
    'الأعدادات',
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  bool isDark = false;
  void changeMode({fromShared}){
    if(fromShared != null)
      {
        isDark = fromShared;
      }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
        emit(ChangeThemeState());
      });
    }
  }

  bool isLang = false;

  void changeEnLang({fromShared}){
    if(fromShared!=null){
      isLang = fromShared;
    }else{
      isLang = false;
      CacheHelper.saveData(key: 'isLang', value: isLang).then((value){
        emit(EnLangState());
      });
    }
  }

  void changeArLang({fromShared}){
    if(fromShared!=null){
      isLang = fromShared;
    }else{
      isLang = true;
      CacheHelper.saveData(key: 'isLang', value: isLang).then((value){
        emit(ArLangState());
      });
    }

  }

  UserModel? userModel;

  void getUserData() {
    emit(GetUserLoadingToDoState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessToDoState());
    }).catchError((error) {
      emit(GetUserErrorToDoState());
      print(error.toString());
    });
  }

  TaskModel? taskModel;

  createToDO({
    required String title,
    required String content,
    required String dateTime,
    required String time,
  }) {
    emit(CreateToDoLoadingState());

    taskModel = TaskModel(title: title, dateTime: dateTime, time: time,content: content);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .add(taskModel!.toMap())
        .then((value) {
          taskModel!.taskId = value.id;
      print('${value.id} value');
      print(taskModel!.taskId);
      createToDOO(
          title: title, dateTime: dateTime, content: content,time: time, taskId: value.id);
      emit(CreateToDoSuccessState());
    }).catchError((error) {
      emit(CreateToDoErrorState());
      print(error.toString());
    });
  }

  createToDOO({
    required String title,
    required String content,
    required String dateTime,
    required String time,
    String? taskId,
  }) {
    emit(CreateToDoLoadingState());

    taskModel =
        TaskModel(title: title, dateTime: dateTime, time: time, taskId: taskId,content: content);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc(taskId)
        .set(taskModel!.toMap())
        .then((value) {
      emit(CreateToDoSuccessState());
    }).catchError((error) {
      emit(CreateToDoErrorState());
      print(error.toString());
    });
  }

  XFile? image;
  ImagePicker pickedFile = ImagePicker();

  Future getProfileImage() async {
    image = await pickedFile.pickImage(source: ImageSource.gallery);
    if (image != null) {
      image = XFile(image!.path);
      print(image!.path);
      emit(PickedImageSuccessState());
    } else {
      print('no image select');
      emit(PickedImageErrorState());
    }
  }

  uploadImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(File(image!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(image: value);
        emit(UploadImageSuccessState());
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
      print(error.toString());
    });
  }

  void updateUser({
    String? image,
  }) {
    emit(UserUpdateLoadingState());

    UserModel model = UserModel(
      name: userModel!.name,
      email: userModel!.email,
      uId: userModel!.uId,
      emailVerify: userModel!.emailVerify,
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
      print(error.toString());
    });
  }

  List<TaskModel> list = [];

  getTodoList() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      list = [];
      docTask = [];
      event.docs.forEach((element) {
        docTask.add(element.id);
        return list.add(TaskModel.fromJson(element.data()));
      });
      emit(GetToDoListSuccessState());
    });
  }

  DateTime selectedDate = DateTime.now();

  Future selectDate(context) {
    return showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: selectedDate,
            lastDate: DateTime(2035))
        .then((value) {
      if (value != null) {
        selectedDate = value;
        emit(ShowDatePickerSuccessState());
      }
    }).catchError((error) {
      emit(ShowDatePickerErrorState());
      print(error.toString());
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  selectTime(context) {
    showTimePicker(
      context: context,
      initialTime: selectedTime,
      cancelText: 'Cancel',
    ).then((value) {
      if (value != null) {
        selectedTime = value;
        emit(ShowTimePickerSuccessState());
      }
    }).catchError((error) {
      emit(ShowTimePickerErrorState());
    });
  }

   removeTask({required String docId}) {
      FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc(docId)
        .delete()
        .then((value) {
          getTodoList();
    }).catchError((error){
      emit(DeleteTaskErrorState());
    });
  }

  updateTask({title, date, time, docId,content}) {
    TaskModel model = TaskModel(
      title: title,
      dateTime: date,
      time: time,
      content: content
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc(docId)
        .update(model.toMap())
        .then((value) {
      getTodoList();
    }).catchError((error) {
      emit(UpdateTaskErrorState());
      print(error.toString());
    });
  }

  removeToken(){
    CacheHelper.removeData(key: 'uId').then((value) {
      emit(RemoveTokenSuccessState());
    });
  }
}
