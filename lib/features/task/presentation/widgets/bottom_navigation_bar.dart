import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/features/task/presentation/screens/add_task_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            bottom: 10,
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
                    _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                    color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
                    size: 30,
                  ),
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
                    _selectedIndex == 1 ? Icons.search : Icons.search_outlined,
                    color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 60),
                IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   CategoryTaskPage.routeName,
                    // );
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationTabChanged(2));
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  icon: Icon(
                    _selectedIndex == 2
                        ? Icons.category
                        : Icons.category_outlined,
                    color: _selectedIndex == 2 ? Colors.pink : Colors.grey,
                    size: 30,
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
                        ? Icons.category
                        : Icons.category_outlined,
                    color: _selectedIndex == 3 ? Colors.pink : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TaskCreationPage.routeName,
                ).then((value) {});
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   builder: (context) => const AddTaskModal(),
                // );
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
