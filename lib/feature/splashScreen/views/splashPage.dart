import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_first_run/is_first_run.dart';

import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      var cubit = context.read<CategoryCubit>();
     await cubit.initialize();
    context.read<DataCubit>().getTasks();
    context.read<DataCubit>().transferPendingTasks();
    _initialize(cubit);
    });
    
  }

  void callback() {
    Navigator.pushReplacementNamed(context, '/first');
  }

  void callback2() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> _initialize(CategoryCubit cubit) async {
    if (await IsFirstRun.isFirstRun() ||
        cubit.categories.isEmpty) {
      Timer(const Duration(seconds: 3), callback);
    } else {
      Timer(const Duration(seconds: 3), callback2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "lib/core/images/work.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
