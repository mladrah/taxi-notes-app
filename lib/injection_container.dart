import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_local_data_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/datasources/ride_remote_date_source.dart';
import 'package:taxi_rahmati/features/manage_work/data/repositories/ride_repository_impl.dart';
import 'package:taxi_rahmati/features/manage_work/domain/repositories/ride_repository.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/get_all_rides.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Manage Work
  sl.registerFactory(
    () => ManageWorkBloc(
      addRideUseCase: sl(),
      getAllRidesUseCase: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AddRide(rideRepository: sl()));
  sl.registerLazySingleton(() => GetAllRides(rideRepository: sl()));

  // Repository
  sl.registerLazySingleton<RideRepository>(
    () => RideRepositoryImpl(
      rideLocalDataSource: sl(),
      rideRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RideRemoteDataSource>(
      () => RideRemoteDataSourceImpl());

  sl.registerLazySingleton<RideLocalDataSource>(
    () => RideLocalDataSourceImpl(sharedPreferences: sl()),
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
