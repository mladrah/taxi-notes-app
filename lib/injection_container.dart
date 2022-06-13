import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/work_unit_local_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/work_unit_remote_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/repositories/work_unit_repository_impl.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/work_unit_repository.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/create_work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/delete_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/delete_work_unit.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_work_units.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/update_ride.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Manage Work
  sl.registerFactory(
    () => ManageWorkBloc(
      createWorkUnitUseCase: sl(),
      deleteWorkUnitUseCase: sl(),
      getWorkUnitsUseCase: sl(),
      addRideUseCase: sl(),
      deleteRideUseCase: sl(),
      updateRideUseCase: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateWorkUnit(workUnitRepository: sl()));
  sl.registerLazySingleton(() => DeleteWorkUnit(workUnitRepository: sl()));
  sl.registerLazySingleton(() => GetWorkUnits(workUnitRepository: sl()));
  sl.registerLazySingleton(() => AddRide(workUnitRepository: sl()));
  sl.registerLazySingleton(() => DeleteRide(workUnitRepository: sl()));
  sl.registerLazySingleton(() => UpdateRide(workUnitRepository: sl()));

  // Repository
  sl.registerLazySingleton<WorkUnitRepository>(
    () => WorkUnitRepositoryImpl(
      rideLocalDataSource: sl(),
      rideRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WorkUnitRemoteDataSource>(
      () => WorkUnitRemoteDataSourceImpl());

  sl.registerLazySingleton<WorkUnitLocalDataSource>(
    () => WorkUnitLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
