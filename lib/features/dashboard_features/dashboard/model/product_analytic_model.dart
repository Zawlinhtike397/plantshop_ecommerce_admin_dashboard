import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class ProductAnalyticModel {
  final PlantModel plant;
  final int unitSold;
  final double totalRevenue;

  ProductAnalyticModel({
    required this.plant,
    required this.unitSold,
    required this.totalRevenue,
  });
}
