import 'package:flutter/cupertino.dart';
import 'package:github_api/domain/usecase/delete_favorite_usecase.dart';
import 'package:github_api/domain/usecase/get_repos_usecase.dart';
import 'package:github_api/domain/usecase/save_favorite_usecase.dart';
import 'package:github_api/presentation/screen/favorites/favorites_screen.dart';
import 'package:github_api/presentation/screen/search/search_data.dart';
import 'package:github_api/presentation/screen/search/search_screen.dart';

import '../../base/bloc.dart';
import '../../model/repos.dart';

abstract class SearchBloc extends Bloc<SearchScreenArguments, SearchData> {
  factory SearchBloc(
    GetReposUseCase getReposUseCase,
    SaveFavoriteUseCase saveFavoriteUseCase,
    DeleteFavoriteUseCase deleteFavoriteUseCase,
  ) =>
      _SearchBloc(
        getReposUseCase,
        saveFavoriteUseCase,
        deleteFavoriteUseCase,
      );

  TextEditingController get controller;

  void goToFavorites();

  void onSearch(String input);

  void onFavoritePressed(Repo repo);
}

class _SearchBloc extends BlocImpl<SearchScreenArguments, SearchData> implements SearchBloc {
  final _screenData = SearchData.init();
  final GetReposUseCase _getReposUseCase;
  final SaveFavoriteUseCase _saveFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;

  @override
  late TextEditingController controller;

  _SearchBloc(
    this._getReposUseCase,
    this._saveFavoriteUseCase,
    this._deleteFavoriteUseCase,
  );

  // todo add search result from loacal storage
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _updateData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void goToFavorites() {
    appNavigator.push(
      FavoritesScreen.page(
        FavoritesScreenArguments(),
      ),
    );
    _screenData.reposList = [];
    _updateData();
  }

  @override
  void onFavoritePressed(Repo repo) {
    repo.isFavorite ? _deleteFavoriteUseCase.call(repo.repoName) : _saveFavoriteUseCase.call(repo.repoName);
    repo.toggleFavorite();
    _updateData();
  }

  // todo add loading while usecase executes
  // todo add logic for checking favorites from cache
  // todo save search to local storage
  @override
  void onSearch(String input) async {
    final List<Repo>? repos = await _getReposUseCase.call(input.trim());
    _screenData.isEmptyRepos = repos == null;
    _screenData.reposList = repos ?? [];
    _updateData();
  }

  _updateData() {
    handleData(
      data: _screenData,
    );
  }
}
