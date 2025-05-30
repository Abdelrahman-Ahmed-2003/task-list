import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/feature/pageView/viewModel/pagecubit.dart';
import 'package:task_list/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  GlobalKey<FormState> formKey = GlobalKey();
  Color clor = const Color.fromARGB(255, 26, 180, 183);
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime date = DateTime.now();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  Task task = Task();
  bool isAdd = true;

  @override
  void initState() {
    super.initState();
    var cubit = context.read<DataCubit>();
    if (cubit.editingTask != null) {
      isAdd = false;
      task = cubit.editingTask!;
      controller.text = task.title;
      controller2.text = task.desc;
      selectedTime = TimeOfDay(
        hour: int.parse(task.time.split(":")[0]),
        minute: int.parse(task.time.split(":")[1]),
      );
      date = DateTime.parse(task.date);
      task.category = cubit.editingTask!.category;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  bool checkTime(TimeOfDay time, DateTime date) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      if (time.hour < DateTime.now().hour) {
        return false;
      } else if (time.hour == DateTime.now().hour &&
          time.minute <= DateTime.now().minute) {
        return false;
      }
      return true;
    } else if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day < DateTime.now().day) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DataCubit>().clearEditingTask();
        return true;
      },
      child: BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          DataCubit cubit = context.watch<DataCubit>();
          var listCat = context.read<CategoryCubit>().categories.toList();

          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        task.category != "" &&
                        checkTime(selectedTime, date)) {
                      if (FocusScope.of(context).hasFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      task.title = controller.text;
                      task.desc = controller2.text;
                      task.time =
                          "${selectedTime.hour} : ${selectedTime.minute}";
                      task.date = date.toString().split(" ")[0];
                      formKey.currentState!.save();

                      if (cubit.tasksinSameTime(task.date, task.time)) {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: S.of(context).foundTaskInSameTime,
                            barrierDismissible: true,
                            showConfirmBtn: false);
                        await Future.delayed(
                            const Duration(milliseconds: 1250));
                        if (Navigator.canPop(context))
                          Navigator.of(context).pop();
                      } else {
                        if (isAdd) {
                          debugPrint(
                              "task to be added: ${task.title} ${task.desc} ${task.time} ${task.date}");
                          task.id = Uuid().v4();
                          await cubit.addTask(task);
                          debugPrint(
                              "task added: ${task.title} ${task.desc} ${task.time} ${task.date}");
                          controller.clear();
                          controller2.clear();
                          selectedTime = TimeOfDay.now();
                          date = DateTime.now();
                          task = Task();
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: S.of(context).taskAddedSuccessfully,
                              barrierDismissible: true,
                              showConfirmBtn: false);
                          await Future.delayed(
                              const Duration(milliseconds: 1250));
                          if (Navigator.canPop(context))
                            Navigator.of(context).pop();
                        } else {
                          cubit.editTask(task);

                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: S.of(context).taskEditedSuccessfully,
                              barrierDismissible: false,
                              showConfirmBtn: false);
                          await Future.delayed(
                              const Duration(milliseconds: 1250));
                          if (Navigator.canPop(context)) {
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    } else if (task.category == "") {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: S.of(context).selectCategory,
                          barrierDismissible: true,
                          showConfirmBtn: false);
                      await Future.delayed(const Duration(milliseconds: 1250));
                      if (Navigator.canPop(context))
                        Navigator.of(context).pop();
                    } else {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: S.of(context).selectTime,
                          barrierDismissible: true,
                          showConfirmBtn: false);
                      await Future.delayed(const Duration(milliseconds: 1250));
                      if (Navigator.canPop(context))
                        Navigator.of(context).pop();
                    }
                  },
                  child: isAdd
                      ? Text(S.of(context).addTask)
                      : Text(S.of(context).editTask),
                ),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Center(
                                child: isAdd
                                    ? Text(
                                        S.of(context).addTask,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      )
                                    : Text(
                                        S.of(context).editTask,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: controller,
                                maxLines: 2,
                                maxLength: 100,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).TaskLabel;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: S.of(context).TaskLabel,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: controller2,
                                maxLines: 2,
                                maxLength: 400,
                                decoration: InputDecoration(
                                    labelText: S.of(context).DescLabel,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(S.of(context).date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                      const Spacer(),
                                      Text(S.of(context).time,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          DateTime? newdate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: date,
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100));
                                          if (newdate != null) {
                                            setState(() {
                                              date = newdate;
                                            });
                                          }
                                        },
                                        child: Text(
                                          date.toString().split(" ")[0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () async {
                                          TimeOfDay? newtime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: selectedTime,
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary: Colors.blue,
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.black,
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.blue),
                                                  ),
                                                  scaffoldBackgroundColor:
                                                      const Color.fromARGB(
                                                          255, 98, 23, 23),
                                                  dialogBackgroundColor:
                                                      const Color.fromARGB(
                                                          255, 98, 23, 23),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (newtime != null) {
                                            setState(() {
                                              selectedTime = newtime;
                                            });
                                          }
                                        },
                                        child: Text(
                                          "${selectedTime.hour} : ${selectedTime.minute}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.09),
                              Column(
                                children: [
                                  Text(S.of(context).category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: listCat.length,
                                            itemBuilder: (context, index) {
                                              return TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    task.category ==
                                                            listCat[index]
                                                        ? Colors.white
                                                        : clor,
                                                  ),
                                                ),
                                                child: Text(
                                                  getTranslatedCategory(
                                                      context, listCat[index]),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    task.category =
                                                        listCat[index];
                                                  });
                                                },
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getTranslatedCategory(BuildContext context, String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return S.of(context).work;
      case 'personal':
        return S.of(context).personal;
      case 'home':
        return S.of(context).homee;
      case 'shopping':
        return S.of(context).shopping;
      case 'health':
        return S.of(context).health;
      default:
        return category; // Fallback to raw if unknown
    }
  }
}
