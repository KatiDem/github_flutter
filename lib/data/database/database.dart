import 'dart:async';
import 'package:sqflite/sqflite.dart';

class ReposDatabase {
  static const name = 'repos.db';
  static const version = 3;

  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Favorites (
      repoName TEXT
      )''');

    await db.execute('''
      CREATE TABLE SearchPrompt (
      searchName TEXT
      )''');
  }
}
