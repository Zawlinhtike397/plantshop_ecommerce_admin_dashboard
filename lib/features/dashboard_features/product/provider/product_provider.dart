import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/product_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/care_guide_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:uuid/uuid.dart';

class ProductProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final heightController = TextEditingController();
  final minTempController = TextEditingController();
  final maxTempController = TextEditingController();
  final stockController = TextEditingController();
  final maxStockController = TextEditingController();
  final priceController = TextEditingController();
  final lightController = TextEditingController();
  final waterController = TextEditingController();
  final humidityController = TextEditingController();
  final soilController = TextEditingController();
  final petSafetyController = TextEditingController();
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  String selectedCategory = 'Outdoor';
  String selectedPotType = 'Ceramic pot';
  Uint8List? thumbnailBytes;
  String? thumbnailFileName;
  String? thumbnailWebUrl;

  final List<Uint8List> additionalImagesBytes = [];
  final List<String> additionalImagesWebUrls = [];
  final List<String> additionalImagesFileNames = [];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    heightController.dispose();
    minTempController.dispose();
    maxTempController.dispose();
    stockController.dispose();
    maxStockController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void handleCategoryChanged(String? newValue) {
    if (newValue != null) {
      selectedCategory = newValue;
      notifyListeners();
    }
  }

  void handlePotTypeChanged(String? newValue) {
    if (newValue != null) {
      selectedPotType = newValue;
      notifyListeners();
    }
  }

  Future<void> pickThumbnail() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();

      thumbnailBytes = bytes;
      thumbnailFileName = image.name;
      thumbnailWebUrl = image.path;

      notifyListeners();
    }
  }

  Future<void> pickAdditionalImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      for (var image in images) {
        final bytes = await image.readAsBytes();

        additionalImagesBytes.add(bytes);
        additionalImagesFileNames.add(image.name);
        additionalImagesWebUrls.add(image.path);

        notifyListeners();
      }
    }
  }

  void removeAdditionalImage(int index) {
    additionalImagesBytes.removeAt(index);
    additionalImagesFileNames.removeAt(index);
    additionalImagesWebUrls.removeAt(index);

    notifyListeners();
  }

  Future<void> submitProduct(BuildContext context) async {
    final bloc = context.read<ProductBloc>();
    String imageUrl = '';
    List<String> additionalImgUrl = [];
    final minTempInInt = int.tryParse(minTempController.text.trim());
    final maxTempInInt = int.tryParse(maxTempController.text.trim());

    if (thumbnailBytes != null && thumbnailFileName != null) {
      try {
        imageUrl = await context.read<ProductRepository>().uploadProductImage(
          thumbnailBytes!,
          '${DateTime.now().millisecondsSinceEpoch}_$thumbnailFileName',
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Image upload failed: $e')));
        }
        return;
      }
    }

    if (additionalImagesBytes.isNotEmpty) {
      try {
        if (context.mounted) {
          final productRepo = context.read<ProductRepository>();

          for (int i = 0; i < additionalImagesBytes.length; i++) {
            final bytes = additionalImagesBytes[i];
            final fileName = additionalImagesFileNames[i];

            final uploadUrl = await productRepo.uploadProductImage(
              bytes,
              '${DateTime.now().millisecondsSinceEpoch}_$fileName',
            );
            additionalImgUrl.add(uploadUrl);
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Image upload failed: $e')));
        }
        return;
      }
    }

    Map<String, CareGuideModel> careGuideData = {
      'light': CareGuideModel(
        title: 'Light',
        description: lightController.text,
      ),
      'water': CareGuideModel(
        title: 'Water',
        description: waterController.text,
      ),
      'humidity': CareGuideModel(
        title: 'Humidity',
        description: humidityController.text,
      ),
      'soil': CareGuideModel(title: 'Soil', description: soilController.text),
      'petSafety': CareGuideModel(
        title: 'Pet Safety',
        description: petSafetyController.text,
      ),
    };

    final generatedUuid = const Uuid().v4();

    final newPlant = PlantModel(
      id: generatedUuid,
      name: nameController.text.trim(),
      originalPrice: double.tryParse(priceController.text) ?? 0.0,
      height: heightController.text.trim(),
      category: selectedCategory,
      stock: int.tryParse(stockController.text) ?? 0,
      maxStock: int.tryParse(maxStockController.text) ?? 0,
      temperature: minTempInInt != null && maxTempInInt != null
          ? [minTempInInt, maxTempInInt]
          : [],
      pot: selectedPotType,
      thumbnailImg: imageUrl,
      imageUrl: additionalImgUrl.isNotEmpty ? additionalImgUrl : [],
      description: descriptionController.text.trim(),
      careGuide: careGuideData,
    );

    bloc.add(AddNewProduct(newPlant));
  }
}
