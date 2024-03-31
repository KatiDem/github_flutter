import 'package:get_it/get_it.dart';

import '../app/app_bloc.dart';
import '../navigation/app_navigator.dart';

void initAppInjector() {
  _initAppModule();
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}
