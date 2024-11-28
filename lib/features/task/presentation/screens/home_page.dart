import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/presentation/bloc/app_theme/app_theme_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/common_widgets/responsive_widgets_scrollable.dart';
import 'package:smart_task/features/task/presentation/screens/category_page.dart';
import 'package:smart_task/widgets/activity_grid.dart';
import 'package:smart_task/widgets/stats_overview.dart';
import 'package:smart_task/widgets/task_list.dart';
import '../bloc/localizations_cubit/localizations_cubit.dart';
import '../widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Widget> content = [
    const HomePageBody(),
    const Text('search'),
    const CategoryTaskPage(),
    const Text(''),
  ];
  static const String routeName = '/home-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.check_box_outlined, size: 32),
              SizedBox(width: 12),
              Text('TaskSmart'),
            ],
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
        body: Row(
          children: [
            Expanded(
              child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (context, state) {
                  return content[state.index];
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenterScrollable(
      maxContentWidth: 800,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocBuilder<AppThemeBloc, AppThemeState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context.read<AppThemeBloc>().add(AppThemeChanged(
                              themeMode: state.themeMode == ThemeMode.dark
                                  ? ThemeMode.light
                                  : ThemeMode.dark,
                            ));
                      },
                      icon: Icon(
                        state.themeMode == ThemeMode.dark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                      ),
                    );
                  },
                ),
                DropdownButton<String>(
                  value: Localizations.localeOf(context).languageCode,
                  icon: const Icon(Icons.language),
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      context
                          .read<LocalizationsCubit>()
                          .changeLanguage(newValue);
                    }
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: Text('ENGLISH'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ru',
                      child: Text('Russia'),
                    ),
                  ],
                ),
              ],
            ),
            AppSize.h16(),
            const ActivityGrid(),
            AppSize.h24(),
            const StatsOverview(),
            AppSize.h24(),
            const TaskList(),
          ],
        ),
      ),
    );
  }
}
