import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/generated/l10n.dart';

class UpdatedCategoryPage extends StatefulWidget {
  const UpdatedCategoryPage({super.key});

  @override
  State<UpdatedCategoryPage> createState() => _UpdatedCategoryPageState();
}

class _UpdatedCategoryPageState extends State<UpdatedCategoryPage> {
  late List<String> tempListCat;
  late List<String> tempSelected;
  late List<bool> isChecked;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CategoryCubit>();
    tempListCat = List.from(cubit.categories);
    tempSelected = List.from(cubit.categories);
    isChecked = tempListCat.map((cat) => tempSelected.contains(cat)).toList();
  }

  void toggleSelection(int index) async {
    final category = tempListCat[index];
    final isCurrentlyChecked = isChecked[index];
    final dataCubit = context.read<DataCubit>();

    if (isCurrentlyChecked && dataCubit.isTaskByCategory(category)) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: S.of(context).areYouSure,
        text: S.of(context).thisIsCategoryHasTasksRemoveAllTasksUnderIt,
        confirmBtnText: S.of(context).yesDelete,
        cancelBtnText: S.of(context).cancel,
        onConfirmBtnTap: () {
          setState(() {
            isChecked[index] = false;
            tempSelected.remove(category);
            dataCubit.removeByCategory(category);
            Navigator.pop(context); // Close the dialog
          });
        },
        onCancelBtnTap: () => Navigator.pop(context),
      );
    } else {
      setState(() {
        isChecked[index] = !isCurrentlyChecked;
        if (isChecked[index]) {
          tempSelected.add(category);
        } else {
          tempSelected.remove(category);
        }
      });
    }
  }

  void _addCategory() {
    final newCat = controller.text.trim();
    if (newCat.isEmpty || tempListCat.contains(newCat)) return;

    setState(() {
      tempListCat.add(newCat);
      isChecked.add(true);
      tempSelected.add(newCat);
      controller.clear();
    });
  }

  Future<void> _onUpdatePressed() async {
    final cubit = context.read<CategoryCubit>();
    cubit.updateCategories(tempSelected);
    await cubit.saveChanges();
  }

  String getTranslatedCategory(BuildContext context, String key) {
    final s = S.of(context);
    final Map<String, String> translations = {
      'work': s.work,
      'personal': s.personal,
      'shopping': s.shopping,
      'health': s.health,
      'home': s.home,
    };
    return translations[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: _onUpdatePressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(S.of(context).update),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  S.of(context).updateCategories,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: S.of(context).newCategory,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addCategory,
                    child: Text(S.of(context).add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: tempListCat.length,
                  itemBuilder: (context, index) {
                    final cat = tempListCat[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(getTranslatedCategory(context, cat)),
                        trailing: Checkbox(
                          value: isChecked[index],
                          onChanged: (_) => toggleSelection(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
