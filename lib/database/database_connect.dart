import 'package:postgres/postgres.dart';

class DatabaseConnect {
  Future<PostgreSQLConnection> openConnection() async {
    return PostgreSQLConnection(
      'localhost',
      5432,
      'shop_database',
      username: 'leandroyu',
      password: 'postgres',
    );
  }
}
