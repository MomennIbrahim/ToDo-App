import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit.dart';
import 'package:to_do_app/layout/layout_screen.dart';
import 'package:to_do_app/layout/state.dart';
import '../share/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
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
                  ToDoCubit.get(context).createToDO(
                    title: titleController.text,
                    time: ToDoCubit.get(context).selectedTime.format(context).toString(),
                    dateTime: ToDoCubit.get(context).selectedDate.toString(),
                  );
                  titleController.text = '';
                  ToDoCubit.get(context).currentIndex = 0;
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }
}
