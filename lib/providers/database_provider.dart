import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/data/sqlite_db.dart';

final databaseProvider = FutureProvider((ref) async {
  final db = await DatabaseHelper().database;
  return db;
});
