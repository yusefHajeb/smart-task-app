import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // _buildMonthSelector(),
            // _buildCalendarHeader(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    _buildTaskTable(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    widget.tasksByDate.sort((a, b) => a.createdAt!
                        .compareTo(b.completedAt ?? DateTime.now()));
                    final date = widget.tasksByDate[index].createdAt!;
                    return Center(
                      child: Text(
                        DateFormat('MMMM yyyy').format(date),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        );
      },
    );
  }

  DataTable _buildTaskTable() {
    List<String> getMonthDayList() {
      final now = DateTime.now();
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      final monthDayList =
          List<String>.generate(daysInMonth, (index) => (index + 1).toString());
      return monthDayList;
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
            headingRowAlignment: MainAxisAlignment.center,
            mouseCursor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.values[3])) {
                return SystemMouseCursors.cell;
              }
              return SystemMouseCursors.click;
            }),
            numeric: true,
            tooltip: '${DateTime.now().year}.${DateTime.now().month}.${i + 1}',
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
            )),
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
                        Navigator.of(context).pop;
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          cells: [
            const DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(''),
                ],
              ),
            ),
            ...getMonthDayList().map(
              (day) => DataCell(
                placeholder: true,
                widget.tasksByDate[i].createdAt?.day == int.parse(day)
                    ? _buildTaskCard(widget.tasksByDate[i])
                    : const SizedBox(width: 1),
              ),
            ),
          ]));
    }

    return DataTable(
      checkboxHorizontalMargin: 0,
      columnSpacing: 20,
      // headingRowHeight: 40,
      headingRowColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.values[3])) {
          return Colors.red;
        }
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      }),
      showCheckboxColumn: true,
      horizontalMargin: 3,
      dataRowHeight: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      columns: column,
      rows: rows,
    );
  }

  Widget _buildTaskCard(
    Task task,
  ) {
    final colors = {
      'Work': Colors.purple[200]!,
      'Marketing': Colors.orange[200]!,
      'Personal': Colors.pink[200]!,
      'Study': Colors.purple[100]!,
      'Other': Colors.blue[200]!,
    };

    final color = colors[task.category] ?? Colors.grey[200]!;

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
                      task.title ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return 'Today'.tr(context);
    }
    if (_isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow'.tr(context);
    }
    return DateFormat('MMMM d, yyyy').format(date);
  }
}
