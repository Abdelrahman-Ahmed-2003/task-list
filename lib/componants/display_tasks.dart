import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/feature/addPage/views/addtaskPage.dart';
import 'package:task_list/generated/l10n.dart';

class DisplayTask extends StatelessWidget {
  final String filterName;
  final String filter;

  const DisplayTask({
    super.key,
    required this.filterName,
    required this.filter,
  });

// Move here to persist across rebuilds.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<DataCubit>();
        cubit.fetchFilteredTasks(filterName, filter);
        
        List tasks = List.from(cubit.filteredList);
        

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).noTasks,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    bool? result = await QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      title: S.of(context).deleteTask,
                      text: S.of(context).AreYouSureYouWantToDeleteThisTask,
                      confirmBtnText: S.of(context).yesDelete,
                      cancelBtnText: S.of(context).cancel,
                      showCancelBtn: true,
                      onConfirmBtnTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(true); // return true
                      },
                      onCancelBtnTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(false); // return false
                      },
                    );

                    return result ?? false;
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (direction) {
                    cubit.deleteTask(index);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: tasks[index].isDone
                            ? Colors.green.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          title: "Information of ${tasks[index].title}",
                          text: tasks[index].desc,
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                value: tasks[index].isDone,
                                onChanged: (bool? value) {
                                  cubit.updateStateOfTask(index, value);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tasks[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        tasks[index].time,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          decoration: tasks[index].isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          getTranslatedCategory(context, tasks[index].category),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!tasks[index].isDone)
                              IconButton(
                                onPressed: () {
                                  final taskToEdit = cubit.data.firstWhere(
                                    (t) => t.title == tasks[index].title,
                                    orElse: () => tasks[index],
                                  );
                                  cubit.editIndex =
                                      cubit.data.indexOf(taskToEdit);
                                  cubit.setEditingTask(taskToEdit);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddTask(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (index == tasks.length - 1) const SizedBox(height: 60),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.indigo[800], thickness: 1);
          },
        );
      },
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
