import 'package:flutter/material.dart';
import 'package:task_list/componants/display_tasks.dart';
import 'package:task_list/feature/home/views/widgets/displaycat.dart';
import 'package:task_list/generated/l10n.dart';

class MianPage extends StatelessWidget {
  const MianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Align(
      //     child: Text(S.of(context).appTitle,
      //         style: Theme.of(context).textTheme.displayMedium),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        // color: Colors.teal,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).appTitle,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const DisplayCAt(),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                S.of(context).today,
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: DisplayTask(filterName: 'date', filter: DateTime.now().toString().split(" ")[0])),
            ),
          ],
        ),
      ),
    );
  }
}
