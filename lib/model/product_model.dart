import 'dart:convert';

import 'model.dart';

class ProductModel implements Model {
  int quantity;
  String name;
  double price;

  @override
  int? id;
  @override
  String? createdAt;
  @override
  String? createdBy;
  @override
  String? deletedAt;
  @override
  String? deletedBy;
  @override
  String? updatedAt;
  @override
  String? updatedBy;

  ProductModel({
    this.id,
    required this.quantity,
    required this.name,
    required this.price,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.updatedAt,
    this.updatedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'name': name,
      'price': price,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'deletedAt': deletedAt,
      'deletedBy': deletedBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      quantity: map['quantity'],
      name: map['name'],
      price: map['price'],
      createdAt: map['createdAt'],
      createdBy: map['createdBy'],
      deletedAt: map['deletedAt'],
      deletedBy: map['deletedBy'],
      updatedAt: map['updatedAt'],
      updatedBy: map['updatedBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  ProductModel copyWith({
    int? quantity,
    String? name,
    double? price,
    int? id,
    String? createdAt,
    String? createdBy,
    String? deletedAt,
    String? deletedBy,
    String? updatedAt,
    String? updatedBy,
  }) {
    return ProductModel(
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedBy: deletedBy ?? this.deletedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
