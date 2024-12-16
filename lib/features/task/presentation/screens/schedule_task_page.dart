import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/routes/routes.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/core/utils/extention.dart';
import 'package:smart_task/features/task/presentation/bloc/localizations_cubit/localizations_cubit.dart';
import 'package:smart_task/features/task/presentation/bloc/schedule_cubit/schedule_cubit.dart';
import 'package:smart_task/features/task/presentation/screens/schedule_test_for_task.dart';
import 'add_task_page.dart';

// ignore: must_be_immutable
class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule-screen';

  const ScheduleScreen({
    super.key,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollTimeTask = ScrollController();

  void scrollToSelectedData(int selectedData) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        selectedData * 55.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void scrollToTimeNow(int timeNow) {
    if (_scrollTimeTask.hasClients) {
      _scrollTimeTask.animateTo(
        timeNow * 100.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    scrollToSelectedData(DateTime.now().day - 1);
    final now = DateTime.now();
    final hour = now.hour >= 12
        ? (now.hour < 7 ? now.hour + 12 + 12 : now.hour + 12)
        : now.hour;
    scrollToTimeNow(hour);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTaskTable(context);
  }

  /// which is comprised of tasks organized by their scheduled dates.
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

    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.canPop ?? false) {
          context.read<CalendarCubit>().selectDay(DateTime.now().day);

          return true;
        } else {
          context.pushNamedAndRemoveUntil(
            Routes.homePage,
            (route) => false,
          );
          return false;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
              return CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            DateFormat(
                                    'EEEE, MMMM d',
                                    context
                                        .watch<LocalizationsCubit>()
                                        .state
                                        .locale
                                        .toString())
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, TaskCreationPage.routeName);
                            },
                            icon: const Icon(Icons.add),
                            label: Text(
                              'Add Task'.tr(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.7),
                                  ),
                            ),
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
                    elevation: 1,
                    toolbarHeight: 76,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ListView.separated(
                        separatorBuilder: (context, index) => AppSize.width8(),
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: getMonthDayList().length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context
                                  .read<CalendarCubit>()
                                  .selectDay(index + 1);
                              scrollToSelectedData(index);
                            },
                            child: BlocBuilder<CalendarCubit, CalendarState>(
                              builder: (context, state) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color:
                                        int.parse(getMonthDayList()[index]) ==
                                                (state).currentSelectedDay
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(getDay(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall),
                                      AppSize.height8(),
                                      Text(getMonthDayList()[index]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: double.infinity, minWidth: 1),
                                child: ScheduleTestForTask(
                                  day: 1,
                                  tasks: state.filteredTasks,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
