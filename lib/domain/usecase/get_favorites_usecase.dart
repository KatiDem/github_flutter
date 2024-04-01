import '../repository/local_storage_repository.dart';
import 'usecase.dart';

class GetFavoriteUseCase implements UseCase<Future<List<String>>> {
  final LocalStorageRepository _repository;

  GetFavoriteUseCase(
    this._repository,
  );

  @override
  Future<List<String>> call() async {
    return await _repository.getFavoritesFromCache();
  }
}
