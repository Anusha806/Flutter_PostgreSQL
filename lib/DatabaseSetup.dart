import 'package:postgres/legacy.dart';
import 'package:postgres/postgres.dart';

class DatabaseSetup {
  final PostgreSQLConnection _connection;

  DatabaseSetup({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  }) : _connection = PostgreSQLConnection(
    host,
    port,
    databaseName,
    username: username,
    password: password,
  );

  Future<void> connect() async {
    await _connection.open();
  }

  Future<void> insertData(String name, String id, String email) async {
    try {
      await _connection.query(
        'INSERT INTO your_table_name (name, id, email) VALUES (@name, @id, @email)',
        substitutionValues: {
          'name': name,
          'id': id,
          'email': email,
        },
      );
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }

  Future<void> close() async {
    await _connection.close();
  }
}
