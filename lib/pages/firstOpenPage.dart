import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/generated/l10n.dart';

class FirstOpen extends StatefulWidget {
  const FirstOpen({super.key});

  @override
  State<FirstOpen> createState() => _FirstOpenState();
}

class _FirstOpenState extends State<FirstOpen> {
  List<String> defaultCategories = [];
  late List<String> tempSelected;
  late List<bool> isChecked;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      // ✅ Safe to use S.of(context) here
      defaultCategories = [
        S.of(context).work,
        S.of(context).personal,
        S.of(context).home,
        S.of(context).shopping,
        S.of(context).health,
      ];
      tempSelected = [];
      isChecked = List.generate(defaultCategories.length, (_) => false);
      _initialized = true;
    }
  }

  void toggleSelection(int index) {
    setState(() {
      isChecked[index] = !isChecked[index];
      String category = defaultCategories[index];
      if (isChecked[index]) {
        tempSelected.add(category);
      } else {
        tempSelected.remove(category);
      }
    });
  }

  Future<void> _onGetStarted() async {
    if (tempSelected.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: S.of(context).noSelectCategory,
        text: S.of(context).selectCategory,
        barrierDismissible: true,
        showConfirmBtn: false,
      );
      return;
    }

    final cubit = context.read<CategoryCubit>();
    cubit.updateCategories(tempSelected);
    await cubit.saveChanges();
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _onGetStarted,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              S.of(context).add,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  S.of(context).selectCategory,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: defaultCategories.length,
                  itemBuilder: (context, index) {
                    final cat = defaultCategories[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(cat),
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
