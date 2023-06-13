import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ToDoCubit.get(context);
        return Scaffold(
          backgroundColor: cubit.isDark == true? Colors.black:Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                cubit.isLang==false?
                cubit.enTitles[cubit.currentIndex]:cubit.arTitles[cubit.currentIndex],
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green[400],
              elevation: 0.0,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.task),
                    label: ToDoCubit.get(context).isLang == false
                        ? 'Task'
                        : 'المهام'),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.add_task),
                    label:cubit.isLang == false
                        ? 'Add Task'
                        : 'أضف مهام جديدة'),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.settings),
                    label: cubit.isLang == false
                        ? 'Setting'
                        : 'الأعدادات'),
              ],
            ),
            body: Directionality(
                textDirection: cubit.isLang==false? TextDirection.ltr:TextDirection.rtl,
                child: cubit.screens[cubit.currentIndex]),
          );
      },
    );
  }
}

var titleController = TextEditingController();
var contentController = TextEditingController();
