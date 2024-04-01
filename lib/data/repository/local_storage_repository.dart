import 'package:sqflite/sqflite.dart';

import '../../domain/repository/local_storage_repository.dart';
import '../../presentation/model/repos.dart';
import '../../presentation/model/search.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final Database _db;

  LocalStorageRepositoryImpl(this._db);

  @override
  Future<void> saveFavoriteToCache(String name) async {
    Batch batch = _db.batch();
    if (name.isNotEmpty) {
      batch.insert(
        'Favorites',
        {'repoName': name},
      );
    }
    await batch.commit();
  }

  @override
  Future<List<String>> getFavoritesFromCache() async {
    final List<Map<String, dynamic>> maps = await _db.query('Favorites');
    return List.generate(maps.length, (i) {
      return maps[i]['repoName'];
    });
  }

  @override
  Future<void> removeFromFavoriteByName(String name) async {
    Batch batch = _db.batch();
    if (name.isNotEmpty) {
      batch.delete(
        'Favorites',
        where: 'repoName = ?',
        whereArgs: [name],
      );
      await batch.commit();
    }
  }

  @override
  Future<void> saveSearchToCache(String remoteSearch) async {
    Batch batch = _db.batch();
    if (remoteSearch.isNotEmpty) {
      batch.insert(
        'SearchPrompt',
        {'searchName': remoteSearch},
      );
    }
    await batch.commit();
  }

  @override
  Future<List<String>> getSearchesFromCache() async {
    final List<Map<String, dynamic>> maps = await _db.query('SearchPrompt');
    return List.generate(maps.length, (i) {
      return maps[i]['searchName'];
    });
  }
}
