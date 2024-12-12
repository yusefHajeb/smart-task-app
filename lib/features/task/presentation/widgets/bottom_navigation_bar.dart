import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/features/task/presentation/screens/add_task_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 9.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationTabChanged(0));
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  icon: Icon(
                      _selectedIndex == 0
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                      color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
                      size: 24.h),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationTabChanged(1));
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  icon: Icon(
                    _selectedIndex == 1
                        ? Icons.calendar_month_rounded
                        : Icons.calendar_month_outlined,
                    color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
                    size: 24.h,
                  ),
                ),
                AppSize.width52(),
                IconButton(
                  onPressed: () {
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationTabChanged(2));
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  icon: Icon(
                    _selectedIndex == 2
                        ? Icons.category_rounded
                        : Icons.category_outlined,
                    color: _selectedIndex == 2 ? Colors.pink : Colors.grey,
                    size: 24.h,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationTabChanged(3));
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  icon: Icon(
                    _selectedIndex == 3
                        ? Icons.person_rounded
                        : Icons.person_2_outlined,
                    color: _selectedIndex == 3 ? Colors.pink : Colors.grey,
                    size: 24.h,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -20.h,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TaskCreationPage.routeName,
                );
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
