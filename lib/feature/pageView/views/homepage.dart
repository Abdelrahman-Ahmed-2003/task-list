import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/feature/addPage/views/addtaskPage.dart';
import 'package:task_list/feature/calender/views/calendarPage.dart';
import 'package:task_list/feature/home/views/main_page.dart';
import 'package:task_list/feature/setting/views/setting.dart';
import 'package:task_list/feature/categories/views/updateCategoryPage.dart';
import 'package:task_list/feature/pageView/viewModel/pagecubit.dart';
import 'widgets/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const MianPage(),
    const AddTask(),
    const UpdatedCategoryPage(),
    const Calendar(),
    Setting(),
  ];

  //  to listen to any notification clicked or not
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(), // Provide the PageCubit
      child: BlocBuilder<PageCubit, int>(
        builder: (context, selectedIndex) {
          final pageCubit = context.watch<PageCubit>();
          return SafeArea(
            child: Scaffold(
              body: PageView(
                controller: pageCubit.pageController,
                onPageChanged: (index) {
                  pageCubit
                      .changePage(index); // Update the page index using the cubit
                },
                children: _pages,
              ),
              bottomNavigationBar: const BottomNavBar(),
            ),
          );
        },
      ),
    );
  }
}
