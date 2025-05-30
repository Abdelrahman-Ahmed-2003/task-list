import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:task_list/core/data/global_data.dart';
import 'package:task_list/cubits/cubit/setting_cubit.dart';
import 'package:task_list/generated/l10n.dart';
class Mode extends StatefulWidget {
  const Mode({super.key});

  @override
  State<Mode> createState() => _ModeState();
}

class _ModeState extends State<Mode> {
  bool modeDark = themeMode == ThemeMode.dark ? true : false;
  @override
  Widget build(BuildContext context) {
    var themeCubit = context.watch<SettingCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).mode,
          style: Theme.of(context).textTheme.displaySmall,
        ),

        FlutterSwitch(
          width: 50.0,
          height: 25.0,
          // toggleSize: 60.0,
          value: modeDark,
          borderRadius: 30.0,
          padding: 2.0,
          activeToggleColor: Colors.black,
          inactiveToggleColor: Colors.black,
          // activeSwitchBorder: Border.all(
          //   color: Colors.orange,
          //   // width: 6.0,
          // ),
          // inactiveSwitchBorder: Border.all(
          //   color: Colors.black,
          //   // width: 6.0,
          // ),
          activeColor: Colors.blue[600]!,
          inactiveColor: Colors.white,
          activeIcon: const Icon(
            Icons.nightlight_round,
            color: Colors.grey,
          ),
          inactiveIcon: const Icon(
            Icons.wb_sunny,
            color: Color(0xFFFFDF5D),
          ),
          onToggle: (val) {
            setState(() {
              modeDark = val;
              themeCubit.setTheme(modeDark == true ? 'dark' : 'light');
            });
          },
        ),
      ],
    );
  }
}
