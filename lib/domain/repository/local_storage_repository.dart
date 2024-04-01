import '../../presentation/model/repos.dart';
import '../../presentation/model/search.dart';

abstract class LocalStorageRepository {
  Future<void> saveFavoriteToCache(String name);

  Future<List<String>> getFavoritesFromCache();

  Future<void> removeFromFavoriteByName(String remoteRepo);

  Future<void> saveSearchToCache(String remoteSearch);

  Future<List<String>> getSearchesFromCache();
}
