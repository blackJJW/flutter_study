import 'package:calander_scheuler/component/main_calander.dart';
import 'package:calander_scheuler/component/schedule_card.dart';
import 'package:calander_scheuler/component/today_banner.dart';
import 'package:calander_scheuler/component/schedule_bottom_sheet.dart';
import 'package:calander_scheuler/component/today_banner.dart';
import 'package:calander_scheuler/const/colors.dart';
import 'package:calander_scheuler/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:calander_scheuler/provider/schedule_provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<ScheduleProvider>();
    final selectedDate = provider.selectedDate;
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalender(
              selectedDate: selectedDate,
              onDaySelected: (selectedDate, focusedDate) =>
                onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8.0),
            // StreamBuilder<List<Schedule>> (
            //   stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //   builder: (context, snapshot) {
            //     return TodayBanner(
            //         selectedDate: selectedDate,
            //         count: snapshot.data?.length ?? 0,
            //     );
            //   },
            // ),
            TodayBanner(selectedDate: selectedDate, count: schedules.length,),
            SizedBox(height: 8.0),
            // Expanded(
            //   child: StreamBuilder<List<Schedule>>(
            //     stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return Container();
            //       }
            //       return ListView.builder(
            //         itemCount: snapshot.data!.length,
            //         itemBuilder: (context, index) {
            //           final schedule = snapshot.data![index];
            //           return Dismissible(
            //               key: ObjectKey(schedule.id),
            //               direction: DismissDirection.startToEnd,
            //               onDismissed: (DismissDirection direction) {
            //                 GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
            //               },
            //               child: Padding(
            //               padding: const EdgeInsets.only(
            //                 bottom: 8.0, left: 8.0, right: 8.0
            //               ),
            //               child: ScheduleCard(
            //                 startTime: schedule.startTime,
            //                 endTime: schedule.endTime,
            //                 content: schedule.content,
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   ),
            // ),
            Expanded(
                child: ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (DismissDirection direction) {
                            provider.deleteSchedule(date: selectedDate, id: schedule.id);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0
                              ),
                            child: ScheduleCard(
                                startTime: schedule.startTime,
                                endTime: schedule.endTime,
                                content: schedule.content,
                            ),
                          ),
                      );
                    },
                )
            )
          ],
        ),
      ),
    );
  }

  void onDaySelected(
      DateTime selectedDate,
      DateTime focusedDate,
      BuildContext context,
      ) {

    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(date: selectedDate,);
    provider.getSchedules(date: selectedDate);

    // setState(() {
    //   this.selectedDate = selectedDate;
    // });
  }
}