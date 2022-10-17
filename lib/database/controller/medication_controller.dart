import 'package:medication_tracker/database/db_controller.dart';
import 'package:medication_tracker/models/medication.dart';
import 'package:sqflite/sqflite.dart';

import '../db_operations.dart';

class MedicationDbController implements DbOperations<Medication> {
  final Database _database = DbController().database;

  @override
  Future<int> create(Medication model) {

    return _database.insert(Medication.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows = await _database
        .delete(Medication.tableName, where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<Medication>> read() async {
    List<Map<String, dynamic>> rowMap =
        await _database.rawQuery('SELECT * FROM medication');
    return rowMap.map((rowMap) => Medication.fromMap(rowMap)).toList();
  }

  @override
  Future<Medication?> show(int id) async {
    List<Map<String, dynamic>> rowMap =
        await _database.rawQuery('SELECT * FROM medication WHERE id=? ', [id]);
    return rowMap.isNotEmpty ? Medication.fromMap(rowMap.first) : null;
  }

  @override
  Future<bool> update(Medication model) async {
    int countOfUpdatedRows = await _database.update(
        Medication.tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return countOfUpdatedRows > 0;
  }
}
