import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/proiority_icons.dart';
import 'package:smart_task/features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

import '../../data/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? taskToEdit;

  const AddTaskScreen({super.key, this.taskToEdit});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;
  String? _selectedCategory;
  int _reminderMinutes = 30;
  bool _isDailyReminder = false;
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      _titleController.text = widget.taskToEdit!.title;
      _descriptionController.text = widget.taskToEdit!.description!;
      _startTime = widget.taskToEdit!.startTime;
      _endTime = widget.taskToEdit!.endTime;
      _selectedCategory = widget.taskToEdit!.category;
      _reminderMinutes = widget.taskToEdit!.reminderMinutes!;
      _isDailyReminder = widget.taskToEdit!.isDailyReminder!;
      _priority = TaskPriority.fromName(widget.taskToEdit!.priority!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskToEdit == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildPrioritySelector(),
            const SizedBox(height: 16),
            _buildTimeSelector(
              label: 'Start Time',
              value: _startTime,
              onSelect: (time) => setState(() => _startTime = time),
            ),
            const SizedBox(height: 16),
            _buildTimeSelector(
              label: 'End Time',
              value: _endTime,
              onSelect: (time) => setState(() => _endTime = time),
            ),
            const SizedBox(height: 16),
            _buildCategorySelector(),
            const SizedBox(height: 16),
            _buildReminderSettings(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveTask,
        label: Text(widget.taskToEdit == null ? 'Add Task' : 'Save Changes'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Priority',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SegmentedButton<TaskPriority>(
              segments: const [
                ButtonSegment(
                  value: TaskPriority.high,
                  label: Text('High'),
                  icon: Icon(Icons.priority_high),
                ),
                ButtonSegment(
                  value: TaskPriority.medium,
                  label: Text('Medium'),
                  icon: Icon(Icons.remove),
                ),
                ButtonSegment(
                  value: TaskPriority.low,
                  label: Text('Low'),
                  icon: Icon(Icons.arrow_downward),
                ),
              ],
              selected: {_priority},
              onSelectionChanged: (Set<TaskPriority> newSelection) {
                setState(() {
                  _priority = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required DateTime? value,
    required Function(DateTime) onSelect,
  }) {
    return ListTile(
      title: Text(label),
      subtitle: Text(
        value?.toString() ?? 'Not selected',
        style: TextStyle(
          color: value == null ? Colors.grey : null,
        ),
      ),
      trailing: const Icon(Icons.access_time),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );

        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
          );

          if (time != null) {
            onSelect(DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ));
          }
        }
      },
    );
  }

  Widget _buildCategorySelector() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      value: _selectedCategory,
      items: const [
        DropdownMenuItem(value: 'work', child: Text('Work')),
        DropdownMenuItem(value: 'personal', child: Text('Personal')),
        DropdownMenuItem(value: 'shopping', child: Text('Shopping')),
      ],
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Widget _buildReminderSettings() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reminder Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Remind me before',
                border: OutlineInputBorder(),
              ),
              value: _reminderMinutes,
              items: const [
                DropdownMenuItem(value: 10, child: Text('10 minutes')),
                DropdownMenuItem(value: 30, child: Text('30 minutes')),
                DropdownMenuItem(value: 60, child: Text('1 hour')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _reminderMinutes = value);
                }
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Daily Reminder'),
              subtitle: const Text('Remind me every day at the start time'),
              value: _isDailyReminder,
              onChanged: (value) => setState(() => _isDailyReminder = value),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate() &&
        _startTime != null &&
        _endTime != null) {
      // final task = Task(
      //   dueDate: DateTime.now(),
      //   id: widget.taskToEdit?.id ?? 234,
      //   title: _titleController.text,
      //   description: _descriptionController.text,
      //   createdAt: widget.taskToEdit?.createdAt ?? DateTime.now(),
      //   startTime: _startTime!,
      //   endTime: _endTime!,
      //   completed: widget.taskToEdit?.completed ?? false,
      //   category: _selectedCategory!,
      //   userId: 1,
      //   reminderMinutes: _reminderMinutes,
      //   isDailyReminder: _isDailyReminder,
      //   priority: _priority.txt,
      // );

      if (widget.taskToEdit == null) {
        context.read<TaskCreationCubit>().submit();
      } else {
        // context.read<TaskBloc>().add(UpdateExistingTask(task));
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
