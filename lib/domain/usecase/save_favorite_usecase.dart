import '../repository/local_storage_repository.dart';
import 'usecase.dart';

class SaveFavoriteUseCase implements UseCaseParams<String, Future<void>> {
  final LocalStorageRepository _repository;

  SaveFavoriteUseCase(
      this._repository,
      );

  @override
  Future<void> call(String name) async {
    await _repository.saveFavoriteToCache(name);
  }
}
