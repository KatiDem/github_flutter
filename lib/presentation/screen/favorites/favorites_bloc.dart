import 'package:github_api/domain/usecase/delete_favorite_usecase.dart';
import 'package:github_api/domain/usecase/get_favorites_usecase.dart';

import '../../base/bloc.dart';
import 'favorites_data.dart';
import 'favorites_screen.dart';

abstract class FavoritesBloc extends Bloc<FavoritesScreenArguments, FavoritesData> {
  factory FavoritesBloc(
    GetFavoriteUseCase getFavoriteUseCase,
    DeleteFavoriteUseCase deleteFavoriteUseCase,
  ) =>
      _FavoritesBloc(
        getFavoriteUseCase,
        deleteFavoriteUseCase,
      );

  void goBack();

  void onFavoriteRemove(String? name);
}

class _FavoritesBloc extends BlocImpl<FavoritesScreenArguments, FavoritesData> implements FavoritesBloc {
  final _screenData = FavoritesData.init();
  final GetFavoriteUseCase _getFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;

  _FavoritesBloc(
    this._getFavoriteUseCase,
    this._deleteFavoriteUseCase,
  );

  @override
  Future<void> initState() async {
    super.initState();
    final namesList = await _getFavoriteUseCase.call();
    _screenData.names = namesList;
    _updateData();
  }

  @override
  void goBack() {
    appNavigator.maybePop();
  }

  @override
  void onFavoriteRemove(String? name) {
    _screenData.names.remove(name);
    _updateData();
    _deleteFavoriteUseCase.call(name ?? '');
  }

  _updateData() {
    handleData(
      data: _screenData,
    );
  }
}
