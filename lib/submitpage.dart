import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';


class SubmitPage extends StatefulWidget {
  final String name;
  final String id;
  final String email;

  const SubmitPage({Key? key, required this.name, required this.id, required this.email}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  late final PostgreSQLConnection _connection;

  @override
  void initState() {
    super.initState();
    // Initialize the database connection
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    // Connect to the PostgreSQL database
    _connection = PostgreSQLConnection(
      'localhost',
      5432, // PostgreSQL default port
      'flutter', // Replace 'your_database_name' with your actual database name
      username: 'postgres', // Replace 'your_username' with your actual username
      password: '123', // Replace 'your_password' with your actual password
    );

    await _connection.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Page'),
        backgroundColor: Colors.blue, // Added background color for the AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${widget.name}'),
            Text('ID: ${widget.id}'),
            Text('Email: ${widget.email}'),
            ElevatedButton(
              onPressed: _insertData,
              child: Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }

  void _insertData() async {
    try {
      await _connection.query(
        'INSERT INTO your_table_name (name, id, email) VALUES (@name, @id, @email)',
        substitutionValues: {
          'name': widget.name,
          'id': widget.id,
          'email': widget.email,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data inserted successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error inserting data: $e'),
        ),
      );
    }
  }
}
