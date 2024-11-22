import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: Stack(
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
                    children: const [
                      OnboardingPage(
                        title: 'Welcome to Smart Task!',
                        description:
                            'Enjoy organizing your tasks easily and effectively.',
                        image: 'assets/svg/welcome.svg',
                        backgroundColor: Color(0xFFF5F3FF),
                      ),
                      OnboardingPage(
                        title: 'Easily Manage Tasks',
                        description:
                            'Create new tasks, set deadlines, and receive reminders.',
                        image: 'assets/svg/manage_tasks.svg',
                        backgroundColor: Color(0xFFE8F5E9),
                      ),
                      OnboardingPage(
                        title: 'Track Your Progress',
                        description:
                            'Monitor your task completion and stay productive.',
                        image: 'assets/svg/process.svg',
                        backgroundColor: Color(0xFFE3F2FD),
                      ),
                      OnboardingPage(
                        title: 'Get Started Now!',
                        description:
                            'Start organizing your tasks and boost your productivity.',
                        image: 'assets/svg/get_started.svg',
                        backgroundColor: Color(0xFFFCE4EC),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 50,
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
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Loading...',
                          semanticsValue: '${_currentPage + 1} / 4',
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).colorScheme.primary,
                          ),
                          value: ((_currentPage) / 3),
                          strokeWidth: 6.0,
                        )),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: MediaQuery.of(context).size.width / 3 - 50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      // height: 200,
                      child: Column(
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.blue,
                              dotColor: Colors.blue,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: const Text('Back'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_pageController.page == 3) {
                                    context
                                        .read<OnboardingBloc>()
                                        .add(CompleteOnboarding());
                                  } else {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text('Get Started'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
