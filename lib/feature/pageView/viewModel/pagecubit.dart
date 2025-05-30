import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/main.dart';

class PageCubit extends Cubit<int> {
  final PageController pageController = PageController();

  PageCubit() : super(0); // Initial index is 0

  // Method to change page
  void changePage(int index) {
    pageController.jumpToPage(index);
    if (index != 1) {
      var dataCubit = navKey.currentState?.context.read<DataCubit>();
      dataCubit?.editIndex = -1;
    }
    emit(index); // Update state with the new index
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
