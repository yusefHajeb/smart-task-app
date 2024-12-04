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

  const CategoryTaskPage({super.key});

  @override
  State<CategoryTaskPage> createState() => _CategoryTaskPageState();
}

class _CategoryTaskPageState extends State<CategoryTaskPage> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCategory(int index) {
    if (_scrollController.hasClients) {
      const itemWidth = 150.0;
      final screenWidth = MediaQuery.of(context).size.width;
      final scrollPosition = _scrollController.position.pixels;
      final itemPosition = index * itemWidth;

      final targetScrollPosition =
          itemPosition - (screenWidth / 2) + (itemWidth / 2);

      if (targetScrollPosition < scrollPosition ||
          targetScrollPosition > (scrollPosition + screenWidth)) {
        _scrollController.animateTo(
          targetScrollPosition.clamp(
            _scrollController.position.minScrollExtent,
            _scrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CategoryTaskBloc, CategoryTaskState>(
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
    );
  }

  Widget _buildCategoryView(BuildContext context, CategoryTaskState loaded) {
    return CustomScrollView(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
            automaticallyImplyLeading: false,
            leading: null,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildCategoryScrollView(context, loaded),
            )),

        // const SizedBox(height: 16),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 10),
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
                    ))
              ]);
        }, childCount: 1)),
      ],
    );
  }

  Widget _buildCategoryScrollView(
      BuildContext context, CategoryTaskState loaded) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(loaded.categories.length, (index) {
          if ((loaded.categories[index] == loaded.selectedCategory)) {}

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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
