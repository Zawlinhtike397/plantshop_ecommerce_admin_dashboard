import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class CsvExportService {
  static Future<void> exportSinglePlant(PlantModel plant) async {
    await _generateAndSaveCsv([
      plant,
    ], '${plant.name.replaceAll(' ', '_')}_data');
  }

  static Future<void> exportMultiplePlants(
    List<PlantModel> plants,
    String filename,
  ) async {
    await _generateAndSaveCsv(plants, filename);
  }

  static Future<void> _generateAndSaveCsv(
    List<PlantModel> plants,
    String fileName,
  ) async {
    List<List<dynamic>> rows = [];

    rows.add([
      "ID",
      "Name",
      "Category",
      "Original Price (MMK)",
      "Height",
      "Stock",
      "Max Stock",
      "Restock Date",
      "Temperature",
      "Pot",
      "Description",
    ]);

    for (var plant in plants) {
      rows.add([
        plant.id,
        plant.name,
        plant.category,
        plant.originalPrice,
        plant.height,
        plant.stock,
        plant.maxStock,
        plant.restockedAt?.toIso8601String() ?? '-',
        plant.temperature,
        plant.pot,
        plant.description,
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    List<int> utf8Bom = [0xEF, 0xBB, 0xBF];
    List<int> encodedCsv = utf8.encode(csvData);

    Uint8List bytes = Uint8List.fromList([...utf8Bom, ...encodedCsv]);

    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      fileExtension: 'csv',
      mimeType: MimeType.csv,
    );
  }
}
