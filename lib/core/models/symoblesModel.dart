class SymoblesModel {
  final String description;
  final String code;

  const SymoblesModel({
    this.description = '',
    this.code = '',
  });

    factory SymoblesModel.fromJson(Map<String, dynamic> json) => SymoblesModel(
        description: json["description"] ?? '',
        code: json["code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
      };
}
