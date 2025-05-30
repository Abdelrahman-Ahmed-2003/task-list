import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';

class AppInitializer {
  static Future<String> initialize(BuildContext context) async {
    // Initialize category cubit
    var cubit = context.read<CategoryCubit>();
    await cubit.initialize();
    
    // Initialize data cubit
    context.read<DataCubit>().getTasks();
    context.read<DataCubit>().transferPendingTasks();
    
    // Check if it's first run
    bool isFirstRun = await IsFirstRun.isFirstRun();
    
    // Navigate based on first run status
    if (isFirstRun || cubit.categories.isEmpty) {
      return '/first';
    } else {
      return '/home';
    }
  }
} 