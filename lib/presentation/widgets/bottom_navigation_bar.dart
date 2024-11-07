import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/widgets/add_task_modal.dart';

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
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
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
                  offset: Offset(0, 3), // changes position of shadow
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
                        icon: const Icon(Icons.home_outlined),
                        color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
                        iconSize: 30,
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
                        icon: const Icon(Icons.search_outlined),
                        color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
                        iconSize: 30,
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
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const AddTaskModal(),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 60,
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
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
