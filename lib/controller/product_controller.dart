import 'dart:async';
import 'dart:convert';
import 'package:first_rest_api/model/product_model.dart';
import 'package:first_rest_api/repository/product_repository.dart';
import 'package:logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'product_controller.g.dart';

class ProductController {
  Logger logger = Logger();

  @Route.get('/getAll/')
  Future<Response> find(Request request) async {
    try {
      final products = await ProductRepository().getAll();
      return Response.ok(
          jsonEncode({
            "products": products.map((products) => products.toMap()).toList(),
          }),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e) {
      logger.e(e);
      return Response.internalServerError();
    }
  }

  @Route.get('/<productId>')
  Future<Response> getProcuctById(Request request, String productId) async {
    try {
      final product = await ProductRepository()
          .getProductById(productId: int.parse(productId));
      return Response.ok(
          jsonEncode({
            "products": product.toMap(),
          }),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
        "status": "error",
        "message": "Product not found",
      }));
    }
  }

  @Route.post("/register/")
  Future<Response> insertProduct(Request request) async {
    try {
      final payload = await request.readAsString();
      final result = jsonDecode(payload);
      ProductModel productModel = ProductModel(
          quantity: int.parse(result["quantity"].toString()),
          name: result["name"],
          price: double.parse(result["price"].toString()),
          createdAt: DateTime.now().toString());
      await ProductRepository().insertProduct(productModel: productModel);
      return Response.ok(
          jsonEncode({
            "status": "sucess",
            "message": "sucess inserting new data",
          }),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
        "status": "error",
        "message": "Error inserting new data",
        "logger": e.toString()
      }));
    }
  }

  @Route.delete("/delete/<productId>")
  Future<Response> deleteProduct(Request request, String productId) async {
    try {
      await ProductRepository().deleteProduct(productId: int.parse(productId));
      return Response.ok(
          jsonEncode({
            "status": "sucess",
            "message": "sucess deleting data",
          }),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
        "status": "error",
        "message": "Error deleting new data",
        "logger": e.toString()
      }));
    }
  }

  @Route.put("/update/")
  Future<Response> updateProduct(Request request) async {
    try {
      final payload = await request.readAsString();
      final result = jsonDecode(payload);
      ProductModel productModel = ProductModel(
          id: int.parse(result["id"].toString()),
          quantity: int.parse(result["quantity"].toString()),
          name: result["name"],
          price: double.parse(result["price"].toString()),
          createdAt: DateTime.now().toString());
      await ProductRepository().updateProduct(productModel: productModel);
      return Response.ok(
          jsonEncode({
            "status": "sucess",
            "message": "sucess updating data",
          }),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e) {
      logger.w(e);
      return Response.internalServerError(
          body: jsonEncode({
        "status": "error",
        "message": "Error updating new data",
        "logger": e.toString()
      }));
    }
  }

  Router get router => _$ProductControllerRouter(this);
}
