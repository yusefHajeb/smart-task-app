import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/core/services/localizations_service.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/update_task_cubit/update_task_cubit.dart';
import 'package:smart_task/features/task/presentation/widgets/task_category_card.dart';

import '../../data/models/task.dart';
import '../bloc/task_cubit/task_cubit.dart';
import 'update_task.dart';

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
      // final scrollPosition = _scrollController.position.pixels;
      final itemPosition = index * itemWidth;

      final targetScrollPosition =
          itemPosition - (screenWidth / 2) + (itemWidth / 2);

      _scrollController.animateTo(
        targetScrollPosition.clamp(
          _scrollController.position.minScrollExtent,
          _scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CategoryTaskBloc, CategoryTaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => _buildErrorState('Something went wrong'),
            initial: (_) => _buildLoadingState(),
            loading: (_) => _buildLoadingState(),
            loaded: (loaded) => _buildCategoryView(context, loaded),
            error: (_) => _buildErrorState('Failed to load categories'),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          AppSize.height16(),
          Text(
            'Loading categories...'.tr(context),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
          AppSize.height16(),
          Text(
            message.tr(context),
            style: TextStyle(fontSize: 16.sp, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryView(BuildContext context, CategoryTaskState loaded) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          elevation: 2,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 70.h,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildCategoryScrollView(context, loaded),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          sliver: loaded.categoryTasks.isEmpty
              ? SliverFillRemaining(child: _buildEmptyState())
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: TaskCategoryCard(
                        task: loaded.categoryTasks[index],
                        onEdit: _handleTaskEdit,
                        onDelete: _handleTaskDelete,
                        onComplete: _handleTaskComplete,
                      ),
                    ),
                    childCount: loaded.categoryTasks.length,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildCategoryScrollView(
      BuildContext context, CategoryTaskState loaded) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            ...List.generate(
              loaded.categories.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: _buildCategoryItem(
                    context, loaded.categories[index], index),
              ),
            ),
            AppSize.width8(),
            _AddCategoryButton(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, CategoryModel category, int index) {
    final isSelected = context
            .select((CategoryTaskBloc bloc) => bloc.state.selectedCategory) ==
        category;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () => _showDeleteCategoryDialog(context, category),
        onTap: () {
          _scrollToCategory(index);
          context
              .read<CategoryTaskBloc>()
              .add(CategoryTaskEvent.categorySelected(category));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(
              //   Icons.folder_outlined,
              //   color: isSelected
              //       ? Colors.white
              //       : Theme.of(context).colorScheme.primary,
              //   size: 20.sp,
              // ),
              // AppSize.width8(),
              Text(
                category.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 64.sp,
            color: Colors.grey[400],
          ),
          AppSize.height16(),
          Text(
            'No tasks in this category'.tr(context),
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          AppSize.height8(),
          Text(
            'Add some tasks to get started!'.tr(context),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleTaskEdit(Task task) {
    final cubit = context.read<UpdateTaskCubit>();
    cubit.setTaskForUpdate(task);

    showUpdateTaskBottomSheet(context, task, isEditFromCategory: true);
  }

  void _handleTaskDelete(String id) {
    context.read<TaskCubit>().deleteTask(int.parse(id));
  }

  void _handleTaskComplete(task) {
    context.read<TaskCubit>().changeTaskStatus(task);
    context
        .read<CategoryTaskBloc>()
        .add(CategoryTaskEvent.categoryTaskChanged(task));
  }

  Future<void> _showDeleteCategoryDialog(
      BuildContext context, CategoryModel category) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Category'.tr(context),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${'Are you sure you want to delete'.tr(context)} '${category.name}'?",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
            AppSize.height16(),
            Text(
              'This will delete all tasks in this category and cannot be undone.'
                  .tr(context),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel'.tr(context),
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<CategoryTaskBloc>()
                  .add(CategoryTaskEvent.deleteCategory(category));
              Navigator.pop(context);
              _showDeleteSuccessSnackBar(category);
            },
            child: Text(
              'Delete'.tr(context),
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteSuccessSnackBar(CategoryModel category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          'Category "${category.name}" deleted successfully.'.tr(context),
          style: TextStyle(fontSize: 14.sp),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _AddCategoryButton extends StatelessWidget {
  const _AddCategoryButton({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showAddCategoryDialog(context),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.add_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Future<void> _showAddCategoryDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    final String? categoryName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Add New Category'.tr(context),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter category name".tr(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel'.tr(context),
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(
              'Add'.tr(context),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (categoryName != null && categoryName.isNotEmpty && context.mounted) {
      _addCategory(context, categoryName);
    }
  }

  void _addCategory(BuildContext context, String name) {
    final category = CategoryModel(
      name: name,
      userId: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      categoryId: DateTime.now().millisecondsSinceEpoch,
    );

    context
        .read<CategoryTaskBloc>()
        .add(CategoryTaskEvent.addCategory(category));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          'Category "$name" added successfully.'.tr(context),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
