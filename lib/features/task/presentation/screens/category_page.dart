import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import 'package:smart_task/features/task/presentation/screens/add_task_page.dart';
import 'package:smart_task/features/task/presentation/widgets/task_category_card.dart';

import '../bloc/task_cubit/task_cubit.dart';

class CategoryTaskPage extends StatefulWidget {
  static const String routeName = '/category-screen';

  const CategoryTaskPage({Key? key}) : super(key: key);

  @override
  State<CategoryTaskPage> createState() => _CategoryTaskPageState();
}

class _CategoryTaskPageState extends State<CategoryTaskPage> {
  final ScrollController _scrollController = ScrollController();
  void scrolleSelectedData(int index) {
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(index * 50.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: BlocConsumer<CategoryTaskBloc, CategoryTaskState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Center(child: Text('Error')),
              initial: (_) => const Center(child: CircularProgressIndicator()),
              loading: (_) => _buildCategoryView(
                  context,
                  const Loaded(
                      categories: [],
                      categoryTasks: [],
                      selectedCategory: null,
                      tasks: [])),
              loaded: (loaded) => _buildCategoryView(context, loaded),
              error: (_) => const Center(child: Text('Error')),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryView(BuildContext context, CategoryTaskState loaded) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildCategoryScrollView(context, loaded),
        const SizedBox(height: 16),
        ...loaded.categoryTasks.map((task) => TaskCategoryCard(
              task: task,
              onEdit: (p0) {
                Navigator.pushNamed(
                  context, TaskCreationPage.routeName,
                  arguments: task, // تمرير المهمة
                );
                context
                    .read<CategoryTaskBloc>()
                    .add(CategoryTaskEvent.categoryTaskChanged(p0));
              },
              onDelete: (value) {
                context.read<TaskCubit>().deleteTask(task.id);
                context
                    .read<CategoryTaskBloc>()
                    .add(CategoryTaskEvent.categoryTaskChanged(task));
              },
              onComplete: (task) {
                context.read<TaskCubit>().changeTaskStatus(task);
                context
                    .read<CategoryTaskBloc>()
                    .add(CategoryTaskEvent.categoryTaskChanged(task));
              },
            )),
      ],
    );
  }

  Widget _buildCategoryScrollView(
      BuildContext context, CategoryTaskState loaded) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: List.generate(loaded.categories.length, (index) {
          if ((loaded.categories[index] == loaded.selectedCategory &&
              index < 4)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrolleSelectedData(index);
            });
          }

          final category = loaded.categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _buildCategoryItem(context, category, index),
          );
        })
          ..add(_buildAddCategoryButton(context)),
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, CategoryModel category, int index) {
    final isSelected = context
            .select((CategoryTaskBloc bloc) => bloc.state.selectedCategory) ==
        category;
    return GestureDetector(
      onLongPress: () {
        _showDeleteCategoryDialog(context, category);
      },
      onTap: () {
        context
            .read<CategoryTaskBloc>()
            .add(CategoryTaskEvent.categorySelected(category));
        // _scrollController.animateTo(
        //   index * 110,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.name),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCategoryButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final categoryName = await _showAddCategoryDialog(context);
        if (categoryName != null &&
            categoryName.isNotEmpty &&
            context.mounted) {
          context.read<CategoryTaskBloc>().add(CategoryTaskEvent.addCategory(
                CategoryModel(
                  name: categoryName,
                  userId: 1,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  categoryId: DateTime.now().millisecondsSinceEpoch,
                ),
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                showCloseIcon: true,
                dismissDirection: DismissDirection.horizontal,
                content: Text('Category "$categoryName" added successfully.')),
          );
        }
      },
      icon: const Icon(Icons.add),
    );
  }

  Future<String?> _showAddCategoryDialog(BuildContext context) {
    String name = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Category'.tr(context)),
          content: TextField(
            onChanged: (value) => name = value,
            decoration: InputDecoration(hintText: "Category Name".tr(context)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr(context)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'.tr(context)),
              onPressed: () => Navigator.of(context).pop(name),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteCategoryDialog(
      BuildContext context, CategoryModel category) async {
    return showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Are you sure you want to delete this category?"
                      .tr(context)),
                  Text('The category and all associated tasks will be deleted.'
                      .tr(context)),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'.tr(context)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Yes, delete'.tr(context)),
                  onPressed: () {
                    context
                        .read<CategoryTaskBloc>()
                        .add(CategoryTaskEvent.deleteCategory(category));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            '${'Category'.tr(context)} "${category.name}" ${'deleted successfully.'.tr(context)}',
                          )),
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to delete this task?'.tr(context),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This action cannot be undone.'.tr(context),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ));
        });
  }
}
