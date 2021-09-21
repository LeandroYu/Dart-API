abstract class Model {
  int? id;
  String? createdAt;
  String? createdBy;
  String? deletedAt;
  String? deletedBy;
  String? updatedAt;
  String? updatedBy;
  Model({
    this.id,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.updatedAt,
    this.updatedBy,
  });
}
