import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/core/colors/AppColors.dart';
import 'package:task_list/core/data/global_data.dart';
import 'package:task_list/cubits/cubit/setting_cubit.dart';
import 'package:task_list/generated/l10n.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<SettingCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(S.of(context).languages,
            style: Theme.of(context).textTheme.displaySmall),
        Flexible(
          child: DropdownMenu<String>(
            initialSelection: lang == 'ar' ? 'ar' : 'en',
            dropdownMenuEntries: [
              DropdownMenuEntry(
                value: 'en',
                label: S.of(context).english,
              ),
              
              DropdownMenuEntry(
                value: 'ar',
                label:  S.of(context).arabic,
              ),
            ],
            textStyle: Theme.of(context).textTheme.displaySmall,
            enableFilter: false,
            enableSearch: false,
            textAlign: TextAlign.right,
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(
                Appcolors.teal,
              ),
            ),
            onSelected: (value) {
              cubit.changeLanguage(value!);
            },
          ),
        ),
      ],
    );
  }
}

