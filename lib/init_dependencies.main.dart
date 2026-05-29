part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

/// Khởi tạo mọi dependency cho app.
Future<void> initDependencies() async {
  _initAuth();
  _initDopamine();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Hive 4 lưu ở app documents directory.
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => LocaleCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator
    // Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initDopamine() {
  serviceLocator
    // Datasource — Hive 4 boxes (mỗi box mở lazy khi cần)
    ..registerFactory<DopamineLocalDataSource>(
      () => DopamineLocalDataSourceImpl(
        activitiesBox: Hive.box(name: 'activities'),
        activityTypesBox: Hive.box(name: 'activity_types'),
        detoxSessionsBox: Hive.box(name: 'detox_sessions'),
      ),
    )
    // Repository
    ..registerFactory<DopamineRepository>(
      () => DopamineRepositoryImpl(localDataSource: serviceLocator()),
    )
    // Usecases — Activity
    ..registerFactory(() => LogActivity(serviceLocator()))
    ..registerFactory(() => GetTodayActivities(serviceLocator()))
    ..registerFactory(() => GetRecentActivities(serviceLocator()))
    // Usecases — Activity types
    ..registerFactory(() => GetActivityTypes(serviceLocator()))
    ..registerFactory(() => CreateActivityType(serviceLocator()))
    ..registerFactory(() => ClassifyActivityType(serviceLocator()))
    // Usecases — Score & analytics
    ..registerFactory(() => GetDailyScore(serviceLocator()))
    ..registerFactory(() => GetWeeklyScores(serviceLocator()))
    ..registerFactory(() => GetCurrentStreak(serviceLocator()))
    // Usecases — Detox
    ..registerFactory(() => StartDetox(serviceLocator()))
    ..registerFactory(() => EndDetox(serviceLocator()))
    ..registerFactory(() => GetActiveDetox(serviceLocator()))
    // Blocs
    ..registerLazySingleton(
      () => HomeBloc(
        getDailyScore: serviceLocator(),
        getWeeklyScores: serviceLocator(),
        getCurrentStreak: serviceLocator(),
        getRecentActivities: serviceLocator(),
        getActiveDetox: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ActivityBloc(
        logActivity: serviceLocator(),
        getRecentActivities: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AnalyticsBloc(getWeeklyScores: serviceLocator()),
    )
    ..registerLazySingleton(
      () => DetoxBloc(
        getActiveDetox: serviceLocator(),
        startDetox: serviceLocator(),
        endDetox: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => OnboardingBloc(
        getActivityTypes: serviceLocator(),
        classifyActivityType: serviceLocator(),
      ),
    );
}
