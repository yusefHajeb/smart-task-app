import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/task.dart';

class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule-screen';
  final Map<DateTime, List<Task>> tasksByDate;

  const ScheduleScreen({super.key, required this.tasksByDate});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _selectedMonth;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                _buildMonthSelector(),
                _buildCalendarHeader(),
                Expanded(
                  child: _buildTaskTimeline(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    setState(() {
                      _selectedMonth = DateTime(
                        _selectedMonth.year,
                        _selectedMonth.month + (index - 6),
                      ).add(const Duration(days: 1));
                    });
                  },
                  itemBuilder: (context, index) {
                    final month = DateTime(
                      _selectedMonth.year,
                      _selectedMonth.month + (index - 6),
                    ).add(const Duration(days: 1));
                    return Center(
                      child: Text(
                        DateFormat('MMMM yyyy').format(month),
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

  Widget _buildTaskTimeline() {
    final tasks = widget.tasksByDate.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final date = tasks[index].key;
        final dayTasks = tasks[index].value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 ||
                !_isSameDay(tasks[index - 1].key, date) ||
                (tasks[index - 1].value.first.completedAt != null &&
                    date.isAfter(tasks[index - 1].value.first.completedAt!)))
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  _formatDate(date),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ...dayTasks.map((task) => _buildTaskCard(task, date)),
          ],
        );
      },
    );
  }

  Widget _buildTaskCard(Task task, DateTime date) {
    final colors = {
      'Work': Colors.purple[200]!,
      'Marketing': Colors.orange[200]!,
      'Personal': Colors.pink[200]!,
      'Study': Colors.purple[100]!,
      'Other': Colors.blue[200]!,
    };

    final color = colors[task.category] ?? Colors.grey[200]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 24),
      child: Row(
        children: [
          Container(
            width: 2,
            height: 80,
            color: Colors.blue,
          ),
          Expanded(
            child: Card(
              color: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.description!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // if (task.dueDate != null)
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
        ],
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
