import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/model/discount_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class CsvExportService {
  static const List<String> _plantHeaders = [
    'ID',
    'Name',
    'Category',
    'Original Price (MMK)',
    'Height',
    'Stock',
    'Max Stock',
    'Restock Date',
    'Temperature',
    'Is Active',
    'Pot',
    'Description',
  ];

  static List<dynamic> _plantRow(PlantModel plant) {
    return [
      plant.id,
      plant.name,
      plant.category,
      plant.originalPrice,
      plant.height,
      plant.stock,
      plant.maxStock,
      plant.restockedAt?.toIso8601String() ?? '-',
      plant.temperature,
      plant.isActive,
      plant.pot,
      plant.description,
    ];
  }

  static Future<void> exportSinglePlant(PlantModel plant) async {
    await exportTable(
      headers: _plantHeaders,
      rows: [_plantRow(plant)],
      fileName: '${plant.name.replaceAll(' ', '_')}_data',
    );
  }

  static Future<void> exportMultiplePlants(
    List<PlantModel> plants,
    String fileName,
  ) async {
    await exportTable(
      headers: _plantHeaders,
      rows: plants.map(_plantRow).toList(),
      fileName: fileName,
    );
  }

  static const List<String> _discountHeaders = [
    'ID',
    'Code',
    'Title',
    'Percentage',
    'Minimum Amount (MMK)',
    'Valid Until',
    'Is Active',
    'First Time Only',
    'Rules',
  ];

  static List<dynamic> _discountRow(DiscountModel discount) {
    return [
      discount.id,
      discount.code,
      discount.title,
      discount.percentage,
      discount.minAmount,
      discount.validUntil.toIso8601String(),
      discount.isActive,
      discount.firstTimeOnly,
      discount.rules.join('; '),
    ];
  }

  static Future<void> exportSingleDiscount(DiscountModel discount) async {
    await exportTable(
      headers: _discountHeaders,
      rows: [_discountRow(discount)],
      fileName: '${discount.code}_discount_data',
    );
  }

  static Future<void> exportMultipleDiscounts(
    List<DiscountModel> discounts,
    String fileName,
  ) async {
    await exportTable(
      headers: _discountHeaders,
      rows: discounts.map(_discountRow).toList(),
      fileName: fileName,
    );
  }

  static Future<void> exportTable({
    required List<String> headers,
    required List<List<dynamic>> rows,
    required String fileName,
  }) async {
    final List<List<dynamic>> csvRows = [headers, ...rows];

    final String csvData = const ListToCsvConverter().convert(csvRows);

    final List<int> utf8Bom = [0xEF, 0xBB, 0xBF];
    final List<int> encodedCsv = utf8.encode(csvData);

    final Uint8List bytes = Uint8List.fromList([...utf8Bom, ...encodedCsv]);

    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      fileExtension: 'csv',
      mimeType: MimeType.csv,
    );
  }
}
