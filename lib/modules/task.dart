import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/state.dart';
import '../layout/layout_screen.dart';
import '../share/components.dart';
import '../share/const.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: BuildCondition(
            condition: ToDoCubit.get(context).list.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  return buildTaskItem(
                      ToDoCubit.get(context).list[index], context, index);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: ToDoCubit.get(context).list.length),
            fallback: (context) => const Center(
              child: Text('No tasks yet'),
            ),
          ),
        );
      },
    );
  }
}

buildTaskItem(model, context, index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.green[100],
    ),
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.title} ',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(model.dateTime.toString())),
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black38),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.time.toString(),
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                ToDoCubit.get(context).deleteTask(docId: docTask[index]);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: AlertDialog(
                      title: const Text('Edit'),
                      elevation: 5.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      content: Column(
                        children: [
                          defaultTextFormField(
                              controller: titleController,
                              keyBoardTyp: TextInputType.text,
                              context: context,
                              text: 'Task Title',
                              onSubmitted: () {}),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                        onPressed: () {
                                          ToDoCubit.get(context)
                                              .selectDate(context);
                                        },
                                        icon: const Icon(
                                          Icons.date_range_outlined,
                                          color: Colors.white,
                                        ))),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: IconButton(
                                        onPressed: () {
                                          ToDoCubit.get(context)
                                              .selectTime(context);
                                        },
                                        icon: const Icon(
                                          Icons.timelapse,
                                          color: Colors.white,
                                        ))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Container(
                              width: 100.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                onPressed: () {
                                  ToDoCubit.get(context).updateTask(
                                    title: titleController.text,
                                    time: ToDoCubit.get(context).selectedTime.format(context).toString(),
                                    date: ToDoCubit.get(context).selectedDate.toString(),
                                    docId: docTask[index],
                                  );
                                  titleController.text = '';
                                  Navigator.of(context).pop();
                                },
                                  )),
                        ],
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
    ),
  );
}
