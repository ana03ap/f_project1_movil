class CategoryModel {
  final String id;
  final String label;

  CategoryModel({required this.id, required this.label});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '', // Si el id es null, asigna un string vacío
      label: json['label'] ?? '', // Si el label es null, asigna un string vacío
    );
  }
}
