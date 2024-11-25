part of 'category_task_bloc.dart';

@freezed
class CategoryTaskState with _$CategoryTaskState {
  const factory CategoryTaskState.initial() = Initial;
  const factory CategoryTaskState.loading() = Loading;
  const factory CategoryTaskState.loaded({
    required List<Task> tasks,
    required List<CategoryModel> categories,
    required List<Task> categoryTasks,
    required CategoryModel? selectedCategory,
  }) = Loaded;
  const factory CategoryTaskState.error({
    required String errorMessage,
  }) = Error;
}

extension LoadedCopyWith on Loaded {
  Loaded copyWith({
    List<Task>? tasks,
    List<CategoryModel>? categories,
    List<Task>? categoryTasks,
    CategoryModel? selectedCategory,
  }) {
    return Loaded(
      tasks: tasks ?? this.tasks,
      categories: categories ?? this.categories,
      categoryTasks: categoryTasks ?? this.categoryTasks,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

extension CategoryTaskStateX on CategoryTaskState {
  bool get isLoading => this is Loading;

  bool get isError => this is Error;

  bool get isLoaded => this is Loaded;

  List<Task> get tasks => this.maybeMap(
        loaded: (loaded) => loaded.tasks,
        orElse: () => [],
      );

  List<CategoryModel> get categories => this.maybeMap(
        loaded: (loaded) => loaded.categories,
        orElse: () => [],
      );

  List<Task> get categoryTasks => this.maybeMap(
        loaded: (loaded) => loaded.categoryTasks,
        orElse: () => [],
      );

  CategoryModel? get selectedCategory => this.maybeMap(
        loaded: (loaded) => loaded.selectedCategory,
        orElse: () => null,
      );

  String get errorMessage => this.maybeMap(
        error: (error) => error.errorMessage,
        orElse: () => '',
      );
}
