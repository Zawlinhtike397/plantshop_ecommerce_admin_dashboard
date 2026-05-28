import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/care_guide_model.dart';

class PlantModel {
  int id;
  String name;
  double originalPrice;
  String height;
  String category;
  int stock;
  int maxStock;
  DateTime? restockedAt;
  String temperature;
  String pot;
  String thumbnailImg;
  List<String> imageUrl;
  String description;
  Map<String, CareGuideModel>? careGuide;

  PlantModel({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.height,
    required this.category,
    required this.stock,
    required this.maxStock,
    this.restockedAt,
    required this.temperature,
    required this.pot,
    required this.thumbnailImg,
    required this.imageUrl,
    required this.description,
    this.careGuide,
  });

  static PlantModel empty() => PlantModel(
    id: 0,
    name: '',
    originalPrice: 0.0,
    height: '',
    category: '',
    stock: 3,
    maxStock: 50,
    restockedAt: null,
    temperature: '',
    pot: '',
    thumbnailImg: '',
    imageUrl: [],
    description: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': originalPrice,
      'height': height,
      'category': category,
      'stock': stock,
      'maxStock': maxStock,
      'lastRestockedAt': restockedAt?.toIso8601String(),
      'temperature': temperature,
      'pot': pot,
      'thumbnailImg': thumbnailImg,
      'imageUrl': imageUrl,
      'description': description,
      'careGuide': careGuide?.map(
        (key, value) => MapEntry(key, {
          'title': value.title,
          'description': value.description,
        }),
      ),
    };
  }

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    Map<String, CareGuideModel>? careGuideMap;
    if (json['careGuide'] != null) {
      careGuideMap = (json['careGuide'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          CareGuideModel(
            title: value['title'] ?? '',
            description: value['description'] ?? '',
          ),
        ),
      );
    }

    return PlantModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      originalPrice: (json['price'] ?? 0).toDouble() ?? 0.0,
      height: json['height']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      maxStock: (json['maxStock'] as num?)?.toInt() ?? 50,
      restockedAt: json['lastRestockedAt'] != null
          ? DateTime.parse(json['lastRestockedAt'])
          : null,
      temperature: json['temperature']?.toString() ?? '',
      pot: json['pot']?.toString() ?? '',
      thumbnailImg: json['thumbnailImg']?.toString() ?? '',
      imageUrl: json['imageUrl'] != null
          ? List<String>.from(json['imageUrl'])
          : [],
      description: json['description']?.toString() ?? '',
      careGuide: careGuideMap,
    );
  }
}
