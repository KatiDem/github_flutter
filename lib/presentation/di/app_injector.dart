import 'package:get_it/get_it.dart';
import 'package:github_api/domain/usecase/delete_favorite_usecase.dart';
import 'package:github_api/domain/usecase/get_favorites_usecase.dart';
import 'package:github_api/domain/usecase/get_repos_usecase.dart';
import 'package:github_api/domain/usecase/save_favorite_usecase.dart';

import '../../data/data_injector.dart';
import '../../domain/domain_injector.dart';
import '../app/app_bloc.dart';
import '../navigation/app_navigator.dart';
import '../screen/favorites/favorites_bloc.dart';
import '../screen/search/search_bloc.dart';
import '../screen/splash/splash_bloc.dart';

Future<void> initAppInjector() async {
  await initDataModule();
  initDomainInjector();
  _initAppModule();
  _initSplashScreenModule();
  _initSearchScreenModule();
  _initFavoritesScreenModule();
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}

void _initSplashScreenModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(),
  );
}

void _initSearchScreenModule() {
  GetIt.I.registerFactory<SearchBloc>(
    () => SearchBloc(
      GetIt.I.get<GetReposUseCase>(),
      GetIt.I.get<SaveFavoriteUseCase>(),
      GetIt.I.get<DeleteFavoriteUseCase>(),
    ),
  );
}

void _initFavoritesScreenModule() {
  GetIt.I.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      GetIt.I.get<GetFavoriteUseCase>(),
      GetIt.I.get<DeleteFavoriteUseCase>(),
    ),
  );
}
