// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ProductControllerRouter(ProductController service) {
  final router = Router();
  router.add('GET', r'/getAll/', service.find);
  router.add('GET', r'/<productId>', service.getProcuctById);
  router.add('POST', r'/register/', service.insertProduct);
  router.add('DELETE', r'/delete/<productId>', service.deleteProduct);
  router.add('PUT', r'/update/', service.updateProduct);
  return router;
}
