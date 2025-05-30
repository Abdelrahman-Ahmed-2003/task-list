import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/componants/display_tasks.dart';
import 'package:task_list/generated/l10n.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focus, cubit) {
    cubit.fetchFilteredTasks("date", day.toString().split(" ")[0]);
    setState(() {
      today = day;
    });
  }

  Color clor = const Color.fromARGB(255, 26, 29, 183);
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DataCubit>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       S.of(context).calender,
      //       style: Theme.of(context).textTheme.displayMedium,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).calender,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${S.of(context).selectedDay} ${today.toString().split(" ")[0]}",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            TableCalendar(
              // calendarFormat: CalendarFormat.week,
              // formatAnimationDuration: const Duration(milliseconds: 300),
              calendarStyle: CalendarStyle(
                defaultTextStyle: Theme.of(context).textTheme.displaySmall!,

              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: Theme.of(context).textTheme.displaySmall!,
                leftChevronIcon: Icon(Icons.chevron_left, color: clor),
                rightChevronIcon: Icon(Icons.chevron_right, color: clor),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(1987, 1, 1),
              lastDay: DateTime.utc(2100, 12, 12),
              onDaySelected: (selectedDay, focusedDay) {
                _onDaySelected(selectedDay, focusedDay, cubit);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: DisplayTask(
                    filterName: "date",
                    filter: today.toString().split(" ")[0],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
