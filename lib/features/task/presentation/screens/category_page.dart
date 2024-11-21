import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/constant/size.dart';
import 'package:smart_task/features/task/data/models/category.dart';
import 'package:smart_task/features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import 'package:smart_task/widgets/task_list.dart';

class CategoryTaskPage extends StatelessWidget {
  static const String routeName = '/category-screen';
  const CategoryTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shrinkWrap: true,
      children: [
        BlocBuilder<CategoryTaskBloc, CategoryTaskState>(
          // buildWhen: (previous, current) =>
          //     previous is Initial && current is Loaded,
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Center(child: Text('error')),
              initial: (_) => const Center(child: CircularProgressIndicator()),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (loaded) => ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // spacing: 8,
                // runSpacing: 8,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // physics: const NeverScrollableScrollPhysics(),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // spacing: 8,
                      // runSpacing: 8,
                      // runAlignment: WrapAlignment.center,
                      // alignment: WrapAlignment.center,
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      // direction: Axis.horizontal,
                      children: [
                        for (var category in loaded.categories)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CategoryTaskBloc>().add(
                                            CategoryTaskEvent.categorySelected(
                                              category,
                                            ),
                                          );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            state.selectedCategory == category
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primaryFixed
                                                    .withOpacity(0.4)
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primaryFixed
                                                    .withOpacity(0.1),
                                      ),
                                      child: Text(category.name),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  state.selectedCategory == category
                                      ? SizedBox(
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primaryFixed
                                                  .withOpacity(0.1),
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primaryFixed,
                                            ),
                                            onPressed: () async {
                                              final categoryName =
                                                  await showDialog<String>(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    title: const Column(
                                                      children: [
                                                        Text(
                                                            'هل تريد بالفعل حذف التصنيف؟'),
                                                        Text(
                                                            'سوف يتم حذف التصنيف وجميع المهام المرتبطة به من قبل والتي لا تتوفَّر بعد ذلك.'),
                                                      ],
                                                    ),
                                                    content: TextButton(
                                                      child:
                                                          const Text('نعم حذف'),
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                CategoryTaskBloc>()
                                                            .add(
                                                              CategoryTaskEvent
                                                                  .deleteCategory(
                                                                category,
                                                              ),
                                                            );
                                                        Navigator.pop(
                                                          context,
                                                          category.name,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                              if (categoryName != null) {
                                                // context
                                                //     .read<CategoryTaskBloc>()
                                                //     .add(
                                                //       CategoryTaskEvent
                                                //           .categoryNameChanged(
                                                //         category,
                                                //         categoryName,
                                                //       ),
                                                //     );
                                              }
                                            },
                                            icon: const Icon(Icons.cancel),
                                          ),
                                        )
                                      : const SizedBox(width: 0),
                                ],
                              ),
                              AppSize.w16(),
                            ],
                          ),
                        IconButton(
                          onPressed: () async {
                            final categoryName = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                String name = '';
                                return AlertDialog(
                                  title: const Text('Add New Category'),
                                  content: TextField(
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Category Name"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Add'),
                                      onPressed: () {
                                        Navigator.of(context).pop(name);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (categoryName != null &&
                                categoryName.isNotEmpty &&
                                context.mounted) {
                              context.read<CategoryTaskBloc>().add(
                                    CategoryTaskEvent.addCategory(
                                      CategoryModel(
                                          name: categoryName,
                                          userId: 1,
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          categoryId: DateTime.now()
                                              .millisecondsSinceEpoch),
                                    ),
                                  );
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),

                  for (var task in loaded.categoryTasks) TaskItem(task: task)

                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: loaded.tasks.length,
                  //   itemBuilder: (context, index) {
                  //     return GestureDetector(
                  //       child: Text(loaded.tasks[index].category),
                  //       onTap: () {
                  //         context.read<CategoryTaskBloc>().add(
                  //               CategoryTaskEvent.categorySelected(
                  //                 loaded.categories[index],
                  //               ),
                  //             );
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
              error: (_) {
                return const Center(child: Text('error'));
              },
            );
          },
        ),
      ],
    );
  }
}
