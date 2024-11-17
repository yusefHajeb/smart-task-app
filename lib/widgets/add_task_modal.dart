// import 'package:flutter/material.dart';
// import 'package:smart_task_app/data/models/task_model.dart';
// import 'package:uuid/uuid.dart';

// class AddTaskScreen extends StatefulWidget {
//   const AddTaskScreen({super.key});

//   @override
//   State<AddTaskScreen> createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   DateTime? _startTime;
//   DateTime? _endTime;
//   String? _selectedCategory;
//   int _reminderMinutes = 30;
//   bool _isDailyReminder = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Task'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             TextFormField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             _buildTimeSelector(
//               label: 'Start Time',
//               value: _startTime,
//               onSelect: (time) => setState(() => _startTime = time),
//             ),
//             const SizedBox(height: 16),
//             _buildTimeSelector(
//               label: 'End Time',
//               value: _endTime,
//               onSelect: (time) => setState(() => _endTime = time),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                 labelText: 'Category',
//                 border: OutlineInputBorder(),
//               ),
//               value: _selectedCategory,
//               items: const [
//                 DropdownMenuItem(value: 'work', child: Text('Work')),
//                 DropdownMenuItem(value: 'personal', child: Text('Personal')),
//                 DropdownMenuItem(value: 'shopping', child: Text('Shopping')),
//               ],
//               onChanged: (value) => setState(() => _selectedCategory = value),
//               validator: (value) {
//                 if (value == null) {
//                   return 'Please select a category';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildReminderSettings(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _saveTask,
//         label: const Text('Save Task'),
//         icon: const Icon(Icons.save),
//       ),
//     );
//   }

//   Widget _buildTimeSelector({
//     required String label,
//     required DateTime? value,
//     required Function(DateTime) onSelect,
//   }) {
//     return ListTile(
//       title: Text(label),
//       subtitle: Text(
//         value?.toString() ?? 'Not selected',
//         style: TextStyle(
//           color: value == null ? Colors.grey : null,
//         ),
//       ),
//       trailing: const Icon(Icons.access_time),
//       onTap: () async {
//         final date = await showDatePicker(
//           context: context,
//           initialDate: value ?? DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime.now().add(const Duration(days: 365)),
//         );

//         if (date != null) {
//           final time = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
//           );

//           if (time != null) {
//             onSelect(DateTime(
//               date.year,
//               date.month,
//               date.day,
//               time.hour,
//               time.minute,
//             ));
//           }
//         }
//       },
//     );
//   }

//   Widget _buildReminderSettings() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Reminder Settings',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<int>(
//               decoration: const InputDecoration(
//                 labelText: 'Remind me before',
//                 border: OutlineInputBorder(),
//               ),
//               value: _reminderMinutes,
//               items: const [
//                 DropdownMenuItem(value: 10, child: Text('10 minutes')),
//                 DropdownMenuItem(value: 30, child: Text('30 minutes')),
//                 DropdownMenuItem(value: 60, child: Text('1 hour')),
//               ],
//               onChanged: (value) {
//                 if (value != null) {
//                   setState(() => _reminderMinutes = value);
//                 }
//               },
//             ),
//             const SizedBox(height: 16),
//             SwitchListTile(
//               title: const Text('Daily Reminder'),
//               subtitle: const Text('Remind me every day at the start time'),
//               value: _isDailyReminder,
//               onChanged: (value) => setState(() => _isDailyReminder = value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveTask() async {
//     if (_formKey.currentState!.validate() &&
//         _startTime != null &&
//         _endTime != null) {
//       final task = TaskModel(
//         id: const Uuid().v4(),
//         title: _titleController.text,
//         description: _descriptionController.text,
//         createdAt: DateTime.now(),
//         startTime: _startTime!,
//         endTime: _endTime!,
//         isCompleted: false,
//         categoryId: _selectedCategory!,
//         userId: 'current_user_id', // Replace with actual user ID
//         reminderMinutes: _reminderMinutes,
//         isDailyReminder: _isDailyReminder,
//       );

//       // Save task to database
//       // TODO: Implement task saving logic

//       // Schedule notification
//       await NotificationService().scheduleTaskReminder(task);

//       Navigator.pop(context);
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }
