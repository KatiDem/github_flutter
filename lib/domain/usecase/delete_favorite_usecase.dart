import '../repository/local_storage_repository.dart';
import 'usecase.dart';

class DeleteFavoriteUseCase implements UseCaseParams<String, Future<void>> {
  final LocalStorageRepository _repository;

  DeleteFavoriteUseCase(
      this._repository,
      );

  @override
  Future<void> call(String name) async {
    await _repository.removeFromFavoriteByName(name);
  }
}
