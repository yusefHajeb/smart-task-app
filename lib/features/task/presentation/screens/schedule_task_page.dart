import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            _buildCalendarHeader(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildTaskTable(),
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

  Widget _buildCalendarHeader() {
    const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekDays
            .map((day) => SizedBox(
                  width: 40,
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ))
            .toList(),
      ),
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
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
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

    column.add(DataColumn(
        label: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: const Text('القيم'))));
    final List<DataColumn> columnsTow = <DataColumn>[];
    for (int i = 0; i < getMonthDayList().length; i++) {
      final date = getDay(i);
      columnsTow.add(
        DataColumn(
            label: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              date == 'Fri' ? const Text('HoleDay') : Text(date),
              Text(i.toString())
            ],
          ),
        )),
      );
    }
    column.addAll(columnsTow);

    for (int i = 0; i < widget.tasksByDate.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(
          Column(
            children: [
              Text(i.toString()),
            ],
          ),
        ),
        ...getMonthDayList().map(
          (day) => DataCell(
            widget.tasksByDate[i].createdAt?.day == int.parse(day)
                ? _buildTaskCard(widget.tasksByDate[i])
                : const SizedBox(),
          ),
        ),
      ]));
    }

    return DataTable(
      columns: column,
      rows: rows,
    );
  }

  // List<Widget> _getTaskWidgetsForDate(Task task, DateTime? date) {
  //   final widgets = <Widget>[];
  //   if (date == null || task.createdAt!.month == date.month) {
  //     widgets.add(const SizedBox(width: 80, height: 80));
  //   }
  //   if (task.completed &&
  //       (date == null || task.completedAt!.month == date.month)) {
  //     widgets.add(_buildTaskCard(task, date ?? DateTime.now()));
  //   }
  //   return widgets;
  // }

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

    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 24),
      width: width,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 900), // مدة الرسوم المتحركة
        curve: Curves.easeIn, // منحنى الرسوم المتحركة
        width: width, // استخدام ارتفاع الرسوم المتحركة
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        task.description,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 7,
                        ),
                      ),
                    ],
                  ),
                ),
                // إذا كانت المهمة لم تنفذ بعد
                if (!task.completed)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      DateFormat('MMM d').format(task.dueDate),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
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
      return 'Today';
    }
    if (_isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    }
    return DateFormat('MMMM d, yyyy').format(date);
  }
}
