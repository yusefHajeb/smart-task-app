import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import '../../data/models/task.dart';

// ignore: must_be_immutable
class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule-screen';
  List<Task> tasksByDate;

  ScheduleScreen({super.key, required this.tasksByDate});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScrollController _scrollController = ScrollController();

  void scrollToSelectedData(int selectedData) {
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(selectedData * 50.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollToSelectedData(DateTime.now().day);
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

    List<DataRow> rows = <DataRow>[];

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

    for (int i = 0; i < widget.tasksByDate.length; i++) {
      rows.add(DataRow(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Task Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildTaskCard(widget.tasksByDate[i]),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        cells: [
          const DataCell(Text('')),
          ...getMonthDayList().map(
            (day) => DataCell(
              widget.tasksByDate[i].createdAt?.day == int.parse(day)
                  ? _buildTaskCard(widget.tasksByDate[i])
                  : const SizedBox(width: 1),
            ),
          ),
        ],
      ));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              leading: null,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1.5,
                        ),
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemExtent: 60.0,
                        scrollDirection: Axis.horizontal,
                        itemCount: getMonthDayList().length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollToSelectedData(index);
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 62.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                                color: int.parse(getMonthDayList()[index]) ==
                                        DateTime.now().day
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getDay(index),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
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
                    ),

                    //
                  ],
                ),
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    checkboxHorizontalMargin: 0,
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    columns: column,
                    rows: rows,
                  ),
                );
                // استبدل هذا بمحتوى الـ DataRow الخاص بك
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    Task task,
  ) {
    final colors = {
      'Work': Colors.purple[200]!,
      'Marketing': Colors.orange[200]!,
      'Personal': Colors.pink[200]!,
      'Study': Colors.purple[200]!,
      'Other': Colors.blue[200]!,
    };

    final color = colors[task.category] ?? Colors.green[200]!;

    // حساب عدد الأيام التي مرت منذ إنشاء المهمة
    final daysPassed = DateTime.now().difference(task.createdAt!).inDays;

    // تحديد الارتفاع بناءً على عدد الأيام
    final double width = 80 + (daysPassed * 10).toDouble();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeIn,
      width: width,
      child: SizedBox(
        width: width,
        child: Card(
          color: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      task.title ?? '---',
                    ),
                  ],
                ),
                // إذا كانت المهمة لم تنفذ بعد
              ],
            ),
          ),
        ),
      ),
    );
  }
}
