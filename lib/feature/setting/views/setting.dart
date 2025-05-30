import 'package:flutter/material.dart';
import 'package:task_list/feature/setting/views/widgets/language.dart';
import 'package:task_list/feature/setting/views/widgets/mode.dart';
import 'package:task_list/generated/l10n.dart';
class Setting extends StatefulWidget {
  Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: SafeArea(
        child: Padding(
          
          padding:const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(S.of(context).setting, style: Theme.of(context).textTheme.displayMedium),
              const Mode(),
              const SizedBox(height: 20,),
              const Language(),
              
            ],
          ),
        ),
      ),
    );
  }
}
