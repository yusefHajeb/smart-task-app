import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/presentation/bloc/localizations_cubit/localizations_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common_widgets/responsive_widgets_scrollable.dart';
import '../../widgets/onboading_widget.dart';
import '../home_page.dart';
import 'on_barding_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late int _currentPage;
  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveCenterScrollable(
              child: BlocBuilder<LocalizationsCubit, LocalizationsState>(
            builder: (context, state) {
              return Stack(
                // shrinkWrap: true,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      controller: _pageController,
                      physics: const PageScrollPhysics(),
                      // physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _pageController.jumpToPage(index);
                        });
                      },
                      children: [
                        OnboardingPage(
                          title: 'Welcome to Smart Task!'.tr(context),
                          description:
                              'Enjoy organizing your tasks easily and effectively.'
                                  .tr(context),
                          image: 'assets/svg/welcome.svg',
                          backgroundColor: const Color(0xFFF5F3FF),
                        ),
                        OnboardingPage(
                          title: 'Easily Manage Tasks'.tr(context),
                          description:
                              'Create new tasks, set deadlines, and receive reminders.'
                                  .tr(context),
                          image: 'assets/svg/manage_tasks.svg',
                          backgroundColor: Color(0xFFE8F5E9),
                        ),
                        OnboardingPage(
                          title: 'Track Your Progress'.tr(context),
                          description:
                              'Monitor your task completio  n and stay productive.'
                                  .tr(context),
                          image: 'assets/svg/process.svg',
                          backgroundColor: const Color(0xFFE3F2FD),
                        ),
                        OnboardingPage(
                          title: 'Get Started Now!'.tr(context),
                          description:
                              'Start organizing your tasks and boost your productivity.'
                                  .tr(context),
                          image: 'assets/svg/get_started.svg',
                          backgroundColor: const Color(0xFFFCE4EC),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 147,
                    right: state.locale == const Locale('en') ? 40 : null,
                    left: state.locale == const Locale('ar') ? 40 : null,
                    child: Center(
                      child: AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 +
                                  ((_currentPage) - (_currentPage.round()))
                                          .abs() *
                                      0.2,
                              child: child,
                            );
                          },
                          child: InkWell(
                            onTap: () {
                              if (_currentPage == 3) {
                                context
                                    .read<OnboardingBloc>()
                                    .add(CompleteOnboarding());
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 16.h,
                                    right: state.locale == const Locale('ar')
                                        ? null
                                        : 16.w,
                                    left: state.locale == const Locale('ar')
                                        ? 16.w
                                        : null,
                                    child: Icon(
                                      _currentPage == 3
                                          ? Icons.check
                                          : Icons.arrow_forward_ios_rounded,
                                      color: _currentPage == 3
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.6),
                                    )),
                                SizedBox(
                                  height: 50.h,
                                  width: 50.w,
                                  child: CircularProgressIndicator(
                                    strokeAlign: 1.3,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.2),
                                    semanticsLabel: 'Loading...',
                                    semanticsValue: '${_currentPage + 1} / 4',
                                    valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                    value: ((_currentPage) / 3),
                                    strokeWidth: 6.0,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    bottom: 35,
                    right: MediaQuery.of(context).size.width / 2.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        // height: 200,
                        child: Column(
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 4,
                              effect: ExpandingDotsEffect(
                                activeDotColor:
                                    Theme.of(context).colorScheme.primary,
                                dotColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 8,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
