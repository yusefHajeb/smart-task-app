import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_test_for_task.dart';
import '../../data/models/task.dart';
import 'add_task_page.dart';

// ignore: must_be_immutable
class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule-screen';
  List<Task> tasksByDate;

  ScheduleScreen({super.key, required this.tasksByDate});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollTimeTask = ScrollController();
  void scrollToSelectedData(int selectedData) {
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(selectedData * 50.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }
      });
    }
  }

  void scrollToTimeNow(int timeNow) {
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (_scrollTimeTask.hasClients) {
          _scrollTimeTask.animateTo(timeNow * 100.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }
      });
    }
  }

  @override
  void initState() {
    scrollToSelectedData(DateTime.now().day - 1);
    final now = DateTime.now();
    final hour = now.hour >= 12
        ? now.hour < 7
            ? now.hour + 12 + 12
            : now.hour + 12
        : now.hour;
    scrollToTimeNow(hour);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTaskTable(context);
  }

  Widget _buildTaskTable(BuildContext context) {
    List<String> getMonthDayList() {
      final now = DateTime.now();
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      return List<String>.generate(
          daysInMonth, (index) => (index + 1).toString());
    }

    final List<String> weekDaysEn = [
      'Mon'.tr(context),
      'Tue'.tr(context),
      'Wed'.tr(context),
      'Thu'.tr(context),
      'Fri'.tr(context),
      'Sat'.tr(context),
      'Sun'.tr(context),
    ];

    String getDay(int dayIndex) {
      final now = DateTime.now();
      final firstDay = DateTime(now.year, now.month, 1);
      final weekday = (firstDay.weekday + dayIndex - 1) % 7;
      return weekDaysEn[weekday];
    }

    // Build columns
    final column = <DataColumn>[];
    column.add(const DataColumn(label: Text('')));

    final List<DataColumn> columnsTow = <DataColumn>[];
    for (int i = 0; i < getMonthDayList().length; i++) {
      final date = getDay(i);
      columnsTow.add(
        DataColumn(
          label: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: DateTime.now().day == i + 1
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                color: DateTime.now().day == i + 1
                    ? Theme.of(context).colorScheme.primaryFixed
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [Text(date), Text((i + 1).toString())],
            ),
          ),
        ),
      );
    }
    column.addAll(columnsTow);
    // for (int i = 0; i < widget.tasksByDate.length; i++) {
    //   rows.add(DataRow(
    //     onLongPress: () {
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: const Text(
    //               'Task Details',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             content: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: _buildTaskCard(widget.tasksByDate[i]),
    //             ),
    //             actions: <Widget>[
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('Close'),
    //               ),
    //             ],
    //           );
    //         },
    //       );
    //     },
    //     cells: [
    //       const DataCell(Text('===')),
    //       ...getMonthDayList().map(
    //         (day) => DataCell(
    //           widget.tasksByDate[i].createdAt?.day == int.parse(day)
    //               ? _buildTaskCard(widget.tasksByDate[i])
    //               : const SizedBox(width: 1),
    //         ),
    //       ),
    //     ],
    //   ));
    // }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollTimeTask,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM d').format(DateTime.now()),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          TaskCreationPage.routeName,
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Task'),
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
                automaticallyImplyLeading: false,
                leading: null,
                floating: false,
                pinned: true,
                scrolledUnderElevation: 0,
                elevation: 1,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 7,
                    ),
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: getMonthDayList().length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print(
                              "\x1B[31m[functionName] - [${DateTime.now()}] - error: \x1B[0m");

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            scrollToSelectedData(index);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transformAlignment: const Alignment(0, 0),
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: int.parse(getMonthDayList()[index]) ==
                                    DateTime.now().day
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.165),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getDay(index),
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                getMonthDayList()[index],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: double.infinity, minWidth: 1),
                          child: ScheduleTestForTask(
                            day: 1,
                            tasks: widget.tasksByDate
                                .where((days) =>
                                    DateTime.now().day == days.createdAt?.day)
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
