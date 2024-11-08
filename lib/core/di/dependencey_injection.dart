import 'package:get_it/get_it.dart';
import 'package:smart_task/data/datasources/base_database.dart';
import 'package:smart_task/data/repository_impl/category_repository_impl.dart';
import 'package:smart_task/data/repository_impl/task_repository_impl.dart';
import 'package:smart_task/domain/repositories/category_repository.dart';
import 'package:smart_task/domain/repositories/task_repository.dart';
import 'package:smart_task/domain/usecases/category/add_category.dart';
import 'package:smart_task/domain/usecases/category/delete_category.dart';
import 'package:smart_task/domain/usecases/category/get_categories.dart';
import 'package:smart_task/domain/usecases/category/get_category.dart';
import 'package:smart_task/domain/usecases/task/add_task.dart';
import 'package:smart_task/domain/usecases/task/delete_task.dart';
import 'package:smart_task/domain/usecases/task/get_task.dart';
import 'package:smart_task/domain/usecases/task/update_task.dart';
import 'package:smart_task/presentation/bloc/task_creation_cubit/task_creation_cubit.dart';

import '../../domain/usecases/task/get_today_task.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<SqfliteDatabase>(SqfliteDatabase());
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(getIt<SqfliteDatabase>()));

  getIt.registerSingleton<TaskRepository>(getIt<TaskRepositoryImpl>());
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(getIt<SqfliteDatabase>()));

//== task UseCase
  getIt.registerLazySingleton<InsertTaskUseCase>(
      () => InsertTaskUseCase(getIt.call()));
  getIt.registerLazySingleton<FetchTaskUseCase>(
      () => FetchTaskUseCase(getIt.call()));
  getIt.registerLazySingleton<GetTodayTasks>(() => getIt.call());
  getIt.registerLazySingleton<DeleteTaskUseCase>(() => getIt.call());
  getIt.registerLazySingleton<UpdateTaskUseCase>(() => getIt.call());

  //==categoryUseCase
  getIt.registerLazySingleton<AddCategoryUseCase>(() => getIt.call());
  getIt.registerLazySingleton<GetCategoriesUseCase>(() => getIt.call());
  getIt.registerLazySingleton<DeleteCategoryUseCase>(() => getIt.call());
  getIt.registerLazySingleton<GetCategoryUseCase>(() => getIt.call());

  getIt.registerFactory<TasKCreationCubit>(() => TasKCreationCubit(
        updateTask: getIt(),
        insertTask: getIt(),
      ));
}
