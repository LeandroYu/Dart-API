import 'package:first_rest_api/database/database_connect.dart';
import 'package:first_rest_api/model/product_model.dart';
import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';

class ProductRepository {
  final Logger logger = Logger();

  Future<List<ProductModel>> getAll() async {
    PostgreSQLConnection? connection;
    List<ProductModel> products = [];
    try {
      connection = await DatabaseConnect().openConnection();
      await connection.open();
      final result = await connection.mappedResultsQuery(
          "SELECT id, name, price, quantity, created_at FROM products");
      for (var element in result) {
        ProductModel productModel = ProductModel(
            id: int.parse(element["products"]!["id"].toString()),
            name: element["products"]!["name"],
            quantity: int.parse(element["products"]!["quantity"].toString()),
            price: double.parse(element["products"]!["price"].toString()),
            createdAt: element["products"]!["created_at"].toString());
        products.add(productModel);
      }
      return products;
    } catch (e) {
      logger.e(e);
      rethrow;
    } finally {
      connection?.close();
    }
  }

  Future<ProductModel> getProductById({required int productId}) async {
    PostgreSQLConnection? connection;
    late ProductModel productModel;
    try {
      connection = await DatabaseConnect().openConnection();
      await connection.open();
      final result = await connection.mappedResultsQuery(
          "SELECT id, name, price, quantity, created_at FROM products WHERE id = @productId;",
          substitutionValues: {"productId": productId.toString()});
      for (var element in result) {
        productModel = ProductModel(
            id: int.parse(element["products"]!["id"].toString()),
            name: element["products"]!["name"],
            quantity: int.parse(element["products"]!["quantity"].toString()),
            price: double.parse(element["products"]!["price"].toString()),
            createdAt: element["products"]!["created_at"].toString());
      }
      return productModel;
    } catch (e, s) {
      logger.e(e);
      logger.w(s);
      rethrow;
    } finally {
      connection?.close();
    }
  }

  Future<void> insertProduct({required ProductModel productModel}) async {
    PostgreSQLConnection? connection;
    try {
      connection = await DatabaseConnect().openConnection();
      await connection.open();
      await connection.execute(
          "INSERT INTO products( name, price, quantity, created_at)	VALUES (@name, @price, @quantity, @created_at);",
          substitutionValues: {
            "name": productModel.name,
            "price": productModel.price,
            "quantity": productModel.quantity,
            "created_at": productModel.createdAt
          });
    } catch (e, s) {
      logger.e(e);
      logger.w(s);
    } finally {
      connection?.close();
    }
  }

  Future<void> deleteProduct({required int productId}) async {
    PostgreSQLConnection? connection;
    connection = await DatabaseConnect().openConnection();
    await connection.open();
    await connection.execute(
        "DELETE FROM public.products WHERE id = @productId;",
        substitutionValues: {"productId": productId.toString()});
  }

  Future<void> updateProduct({required ProductModel productModel}) async {
    PostgreSQLConnection? connection;
    connection = await DatabaseConnect().openConnection();
    await connection.open();
    await connection.execute(
        "UPDATE products SET name = @name, price = @price, quantity = @quantity , created_at = @created_at	WHERE id = @productId;",
        substitutionValues: {
          "productId": productModel.id,
          "name": productModel.name,
          "price": productModel.price,
          "quantity": productModel.quantity,
          "created_at": productModel.createdAt
        });
  }
}
