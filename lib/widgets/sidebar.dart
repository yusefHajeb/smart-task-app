import 'package:flutter/material.dart';
import 'package:smart_task/core/constant/size.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.check_box_outlined,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
                AppSize.height12(),
                const Text(
                  'TaskMaster',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _NavItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            isSelected: selectedIndex == 0,
            onTap: () => onIndexChanged(0),
          ),
          _NavItem(
            icon: Icons.check_circle_outline,
            label: 'Tasks',
            isSelected: selectedIndex == 1,
            onTap: () => onIndexChanged(1),
          ),
          _NavItem(
            icon: Icons.calendar_today_outlined,
            label: 'Calendar',
            isSelected: selectedIndex == 2,
            onTap: () => onIndexChanged(2),
          ),
          _NavItem(
            icon: Icons.pie_chart_outline,
            label: 'Statistics',
            isSelected: selectedIndex == 3,
            onTap: () => onIndexChanged(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
              ),
              AppSize.height12(),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
