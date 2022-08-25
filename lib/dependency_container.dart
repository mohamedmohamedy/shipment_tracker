import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/datasources/remote_auth_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_implement.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/sign_in_anonymously.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/shipment/data/datasources/remote_data_source.dart';
import 'features/shipment/data/repositories/shipment_repository_implementation.dart';
import 'features/shipment/domain/repositories/shipment_repository.dart';
import 'features/shipment/domain/usecases/find_shipment_by_id.dart';
import 'features/shipment/domain/usecases/get_all_shipments.dart';
import 'features/shipment/presentation/bloc/shipment_bloc.dart';
import 'features/submit/data/datasources/submit_form_data_source.dart';
import 'features/submit/data/repositories/submit_repository_implement.dart';
import 'features/submit/domain/repositories/submit_repository.dart';
import 'features/submit/domain/usecases/submit_form_usecase.dart';
import 'features/submit/presentation/bloc/submit_bloc.dart';
import 'features/tracker/data/datasources/remote_data_source.dart';
import 'features/tracker/data/repositories/tracker_repository_implementation.dart';
import 'features/tracker/domain/repositories/tracker_repository.dart';
import 'features/tracker/domain/usecases/add_tracker.dart';
import 'features/tracker/domain/usecases/get_all_tracker.dart';
import 'features/tracker/presentation/bloc/tracker_bloc.dart';

import 'core/location/location_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///  Authentication Features

  // Bloc
  sl.registerFactory(() => AuthenticationBloc(signInAnonymouslyUseCase: sl()));

  // Use cases

  sl.registerLazySingleton(
      () => SignInAnonymouslyUseCase(authRepository: sl()));

  // Repository

  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(firebaseAuthAnonymously: sl(), deviceStatus: sl()));

  // DataSources

  sl.registerLazySingleton<RemoteAuthDataSource>(
      () => RemoteAuthDataSourceImpl());

  // // Network info
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // // External
  // sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth);

  //_____________________________________________________________________________________

  ///  Submit features

  // Bloc
  sl.registerFactory(() => SubmitBloc(submitFormUseCase: sl()));

  // UseCase
  sl.registerLazySingleton(() => SubmitFormUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SubmitFormRepository>(() =>
      SubmitRepositoryImpl(submitFormDataSource: sl(), deviceStatus: sl()));

  // Data source
  sl.registerLazySingleton<SubmitFormDataSource>(
      () => SubmitFormDataSourceImpl());

  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // sl.registerLazySingleton(() => FirebaseFirestore);

  //_____________________________________________________________

  ///  shipment Feature

// Bloc
  sl.registerFactory(() => ShipmentBloc(sl(), sl(), sl()));

// UseCase
  sl.registerLazySingleton(() => GetAllShipmentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FindShipmentByIdUseCase(sl()));

// Repository
  sl.registerLazySingleton<ShipmentRepository>(
      () => ShipmentRepositoryImplementation(sl(), sl()));

// Data Source
  sl.registerLazySingleton<ShipmentsRemoteDataSource>(
      () => ShipmentsFireBaseDataSource());

  //__________________________________________________________________

  /// Trackers Feature

  // Bloc
  sl.registerFactory(() => TrackerBloc(sl(), sl(), sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllTrackerUseCase(sl()));
  sl.registerLazySingleton(() => AddTrackerUseCase(sl()));
  sl.registerLazySingleton(() => LocationHelper());

  // Repository
  sl.registerLazySingleton<TrackerRepository>(
      () => TrackerRepositoryImplementation(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => FireBaseRemoteDataSourceImplementation());
}
