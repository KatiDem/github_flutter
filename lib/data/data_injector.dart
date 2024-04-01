import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_api/data/repository/github_repository.dart';
import 'package:github_api/data/repository/local_storage_repository.dart';
import 'package:github_api/data/service/api_base_service.dart';
import 'package:github_api/data/service/service_payload.dart';
import 'package:github_api/data/utils/const.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/repository/github_repository.dart';
import '../domain/repository/local_storage_repository.dart';
import 'database/database.dart';

Future<void> initDataModule() async {
  _initInterceptorModule();
  _initApiModule();
  await _initDatabaseModule();
  _initRepositoryModule();
}

void _initApiModule() {
  const baseUrl = 'https://api.github.com';

  GetIt.I.registerSingleton<Dio>(
    _buildGithubApiDio([
      GetIt.I.get<LogInterceptor>(),
    ], baseUrl),
    instanceName: 'Github',
  );
  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
    ApiServiceImpl(
      GetIt.I.get<Dio>(instanceName: 'Github'),
    ),
  );
}

Future<void> _initDatabaseModule() async {
  GetIt.I.registerSingleton<ReposDatabase>(
    ReposDatabase(),
  );

  GetIt.I.registerSingleton<Database>(
    await openDatabase(
      ReposDatabase.name,
      onCreate: (db, version) => GetIt.I.get<ReposDatabase>().createDB(db, version),
      version: ReposDatabase.version,
    ),
  );
}

Dio _buildGithubApiDio(List<Interceptor> interceptors, String baseUrl) {
  final options = BaseOptions(
    sendTimeout: Config.sendTimeout,
    receiveTimeout: Config.receiveTimeout,
    connectTimeout: Config.connectTimeout,
    baseUrl: baseUrl,
  );

  final dio = Dio(options);
  return dio;
}

void _initInterceptorModule() {
  GetIt.I.registerSingleton<LogInterceptor>(
    LogInterceptor(requestBody: true, responseBody: true),
  );
}

void _initRepositoryModule() {
  GetIt.I.registerSingleton<GithubApiRepository>(
    GithubAPIRepositoryImpl(
      GetIt.I.get<ApiBaseService>(),
    ),
  );
  GetIt.I.registerSingleton<LocalStorageRepository>(
    LocalStorageRepositoryImpl(
      GetIt.I.get<Database>(),
    ),
  );
}
