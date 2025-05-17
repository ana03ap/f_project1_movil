class CategoryModel {
  final String id;
  final String label;
  final String type;

  CategoryModel({required this.id, required this.label, required this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      label: json['label'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
