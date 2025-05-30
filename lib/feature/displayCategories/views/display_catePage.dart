import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/componants/display_tasks.dart';
import 'package:task_list/generated/l10n.dart';

class DisplayCatepage extends StatefulWidget {
  const DisplayCatepage({super.key});

  @override
  State<DisplayCatepage> createState() => _DisplayCatepageState();
}

class _DisplayCatepageState extends State<DisplayCatepage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DataCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title:Text(
                "${S.of(context).allTasksINn} ${cubit.category}",
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              
              // const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DisplayTask(
                    filterName: "category",
                    filter: cubit.category,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
