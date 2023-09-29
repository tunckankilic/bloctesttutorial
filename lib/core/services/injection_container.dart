import 'package:bloctesttutorial/src/authentication/data/datasources/datasources.dart';
import 'package:bloctesttutorial/src/authentication/data/repositories/repositories.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:bloctesttutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Create a singleton instance of GetIt to manage dependencies.
final sl = GetIt.instance;

// Asynchronously initialize the dependencies.
Future<void> init() async {
  sl
    // Register the AuthenticationCubit with a factory constructor.
    ..registerFactory(() => AuthenticationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))

    // Register the CreateUser and GetUsers use cases with lazy singletons.
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Register the AuthenticationRepository with a lazy singleton.
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // Register the AuthenticationRemoteDataSource with a lazy singleton.
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // Register an HTTP Client as a lazy singleton.
    ..registerLazySingleton(http.Client.new);
}
