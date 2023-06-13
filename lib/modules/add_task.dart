import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/layout_screen.dart';
import 'package:to_do_app/layout/state.dart';
import '../share/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   var dateController = TextEditingController();
   var timeController = TextEditingController();

    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultTextFormField(
                    controller: titleController,
                    keyBoardTyp: TextInputType.text,
                    context: context,
                    text: ToDoCubit.get(context).isLang == false
                        ? 'Task Title'
                        : 'أسم المهام',
                    maxLines: 1,
                    onSubmitted: () {}),
                const SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                    controller: contentController,
                    maxLines: 10,
                    keyBoardTyp: TextInputType.text,
                    context: context,
                    text: ToDoCubit.get(context).isLang == false
                        ? 'Content'
                        : 'المحتوى',
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
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20.0)),
                              width: 100.0,
                              child: IconButton(
                                  onPressed: () {
                                    ToDoCubit.get(context)
                                        .selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.white,
                                  ))),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(ToDoCubit.get(context).isLang == false
                              ? 'Select Date'
                              : 'أختر التاريخ'),
                          defaultTextFormField(
                              controller: dateController,
                              keyBoardTyp: TextInputType.none,
                              context: context,
                              enabled: false,
                              text: DateFormat('MMMEd')
                                  .format(DateTime.parse(ToDoCubit.get(context).selectedDate.toString())),
                              onSubmitted: (){}
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20.0)),
                              width: 100.0,
                              child: IconButton(
                                  onPressed: () {
                                    ToDoCubit.get(context)
                                        .selectTime(context);
                                  },
                                  icon: const Icon(
                                    Icons.timelapse,
                                    color: Colors.white,
                                  ))),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(ToDoCubit.get(context).isLang == false
                              ? 'Select Time'
                              : 'أختر الوقت'),
                          defaultTextFormField(
                              controller: dateController,
                              keyBoardTyp: TextInputType.none,
                              enabled: false,
                              context: context,
                              text: ToDoCubit.get(context).selectedTime.format(context).toString(),
                              onSubmitted: (){}
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70.0,
                ),
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: FloatingActionButton(
                    tooltip:
                        ToDoCubit.get(context).isLang == false ? 'Add' : 'أضف',
                    elevation: 7.0,
                    onPressed: () {
                      ToDoCubit.get(context).createToDO(
                        title: titleController.text,
                        content: contentController.text,
                        time: ToDoCubit.get(context)
                            .selectedTime
                            .format(context)
                            .toString(),
                        dateTime:
                            ToDoCubit.get(context).selectedDate.toString(),
                      );
                      titleController.text = '';
                      contentController.text = '';
                      ToDoCubit.get(context).currentIndex = 0;
                    },
                    child: Text(
                        ToDoCubit.get(context).isLang == false ? 'Add' : 'اضافة',style: const TextStyle(fontSize: 20.0),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
