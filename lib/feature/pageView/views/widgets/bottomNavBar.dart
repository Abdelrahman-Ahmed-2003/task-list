import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/feature/pageView/viewModel/pagecubit.dart';
import 'package:task_list/generated/l10n.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, selectedIndex) {
        return Container(
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Icons.home_outlined, Icons.home, S.of(context).home, selectedIndex),
              _buildNavItem(context, 1, Icons.add_task_outlined, Icons.add_task, S.of(context).task, selectedIndex),
              _buildNavItem(context, 2, Icons.category_outlined, Icons.category, S.of(context).categories, selectedIndex),
              _buildNavItem(context, 3, Icons.calendar_month_outlined, Icons.calendar_month, S.of(context).calender, selectedIndex),
              _buildNavItem(context, 4, Icons.settings_outlined, Icons.settings, S.of(context).setting, selectedIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData outlinedIcon, IconData filledIcon, String label, int selectedIndex) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => context.read<PageCubit>().changePage(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? filledIcon : outlinedIcon,
                key: ValueKey(isSelected),
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}