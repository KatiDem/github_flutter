import 'package:get_it/get_it.dart';
import 'package:github_api/domain/repository/github_repository.dart';
import 'package:github_api/domain/repository/local_storage_repository.dart';
import 'package:github_api/domain/usecase/delete_favorite_usecase.dart';
import 'package:github_api/domain/usecase/get_favorites_usecase.dart';
import 'package:github_api/domain/usecase/get_repos_usecase.dart';
import 'package:github_api/domain/usecase/save_favorite_usecase.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<GetReposUseCase>(
    () => GetReposUseCase(GetIt.I.get<GithubApiRepository>()),
  );
  GetIt.I.registerFactory<GetFavoriteUseCase>(
    () => GetFavoriteUseCase(GetIt.I.get<LocalStorageRepository>()),
  );
  GetIt.I.registerFactory<SaveFavoriteUseCase>(
    () => SaveFavoriteUseCase(GetIt.I.get<LocalStorageRepository>()),
  );
  GetIt.I.registerFactory<DeleteFavoriteUseCase>(
    () => DeleteFavoriteUseCase(GetIt.I.get<LocalStorageRepository>()),
  );
}
