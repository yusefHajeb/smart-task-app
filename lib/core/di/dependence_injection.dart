import 'package:get_it/get_it.dart';
import 'package:smart_task/features/task/data/datasources/base_database.dart';
import 'package:smart_task/features/task/data/repository_impl/category_repository_impl.dart';
import 'package:smart_task/features/task/data/repository_impl/task_repository_impl.dart';
import 'package:smart_task/features/task/domain/repositories/category_repository.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/category/add_category.dart';
import 'package:smart_task/features/task/domain/usecases/category/delete_category.dart';
import 'package:smart_task/features/task/domain/usecases/category/get_category.dart';
import 'package:smart_task/features/task/domain/usecases/task/add_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/delete_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/get_task.dart';
import 'package:smart_task/features/task/domain/usecases/task/update_task.dart';
import 'package:smart_task/features/task/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/task_cubit/task_cubit.dart';

import '../../features/task/domain/usecases/category/get_categories.dart';
import '../../features/task/domain/usecases/task/get_today_task.dart';
import '../../features/task/presentation/bloc/category_task_bloc/category_task_bloc.dart';
import '../../features/task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

var sl = GetIt.instance;

Future<void> setupGetIt() async {
  sl.registerLazySingleton<SqfliteDatabase>(() => SqfliteDatabase());
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl()));

  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        sl.call(),
      ));

//== task UseCase
  sl.registerLazySingleton<InsertTaskUseCase>(() => InsertTaskUseCase(sl()));
  sl.registerLazySingleton<FetchTaskUseCase>(() => FetchTaskUseCase(sl.call()));
  sl.registerLazySingleton<GetTodayTasks>(() => GetTodayTasks(sl.call()));
  sl.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(sl.call()));
  sl.registerLazySingleton<UpdateTaskUseCase>(
      () => UpdateTaskUseCase(sl.call()));

  //==categoryUseCase
  sl.registerLazySingleton<AddCategoryUseCase>(
      () => AddCategoryUseCase(sl.call()));

  sl.registerLazySingleton<DeleteCategoryUseCase>(
      () => DeleteCategoryUseCase(sl.call()));
  sl.registerLazySingleton<GetCategoryUseCase>(
      () => GetCategoryUseCase(sl.call()));
  sl.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(sl.call()));
  // sl.registerFactory<AppThemeBloc>(() => AppThemeBloc());
  sl.registerFactory<BottomNavigationBloc>(() => BottomNavigationBloc());
  sl.registerFactory<TaskCubit>(() => TaskCubit(
      insertTask: sl(),
      updateTaskUseCase: sl(),
      fetchTask: sl(),
      delete: sl()));
  sl.registerFactory<TaskCreationCubit>(() => TaskCreationCubit(sl()));
  sl.registerFactory<CategoryTaskBloc>(() => CategoryTaskBloc(
        insertCategory: sl(),
        getCategories: sl(),
        deleteCategory: sl(),
        getTasks: sl(),
      ));
}
