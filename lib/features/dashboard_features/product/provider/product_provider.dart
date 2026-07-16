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
  bool _isActive = true;
  bool get isActive => _isActive;
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  String selectedCategory = 'Outdoor';
  String selectedPotType = 'Ceramic pot';

  String? _editingPlantId;
  String? get editingPlantId => _editingPlantId;

  Uint8List? thumbnailBytes;
  String? thumbnailFileName;
  String? thumbnailWebUrl;

  String? originalThumbnailUrl;
  final List<String> imagesToDelete = [];

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
    final urlToRemove = additionalImagesWebUrls[index];
    if (urlToRemove.startsWith('http')) {
      imagesToDelete.add(urlToRemove);
    }

    additionalImagesBytes.removeAt(index);
    additionalImagesFileNames.removeAt(index);
    additionalImagesWebUrls.removeAt(index);

    notifyListeners();
  }

  Future<void> submitProduct(BuildContext context) async {
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
      isActive: _isActive,
    );

    if (context.mounted) {
      context.read<ProductBloc>().add(AddNewProduct(newPlant));
    }
  }

  void initializeEditForm(PlantModel plant) {
    clearForm();
    _editingPlantId = plant.id;
    _isActive = plant.isActive ?? true;

    nameController.text = plant.name;
    descriptionController.text = plant.description;
    heightController.text = plant.height;
    stockController.text = plant.stock.toString();
    maxStockController.text = plant.maxStock.toString();
    priceController.text = plant.originalPrice.toString();
    selectedCategory = plant.category;
    selectedPotType = plant.pot;

    if (plant.temperature.length >= 2) {
      minTempController.text = plant.temperature[0].toString();
      maxTempController.text = plant.temperature[1].toString();
    }

    lightController.text = plant.careGuide!['light']?.description ?? '';
    waterController.text = plant.careGuide!['water']?.description ?? '';
    humidityController.text = plant.careGuide!['humidity']?.description ?? '';
    soilController.text = plant.careGuide!['soil']?.description ?? '';
    petSafetyController.text = plant.careGuide!['petSafety']?.description ?? '';

    originalThumbnailUrl = plant.thumbnailImg;
    thumbnailWebUrl = plant.thumbnailImg;

    for (var url in plant.imageUrl) {
      additionalImagesWebUrls.add(url);
      additionalImagesFileNames.add('network_file');
      additionalImagesBytes.add(Uint8List(0));
    }

    notifyListeners();
  }

  Future<void> submitEditedProduct(BuildContext context) async {
    if (_editingPlantId == null) return;

    final bloc = context.read<ProductBloc>();
    final minTempInInt = int.tryParse(minTempController.text.trim());
    final maxTempInInt = int.tryParse(maxTempController.text.trim());

    String finalThumbnailUrl = thumbnailWebUrl ?? '';
    if (thumbnailBytes != null && thumbnailFileName != null) {
      try {
        finalThumbnailUrl = await context
            .read<ProductRepository>()
            .uploadProductImage(
              thumbnailBytes!,
              '${DateTime.now().millisecondsSinceEpoch}_$thumbnailFileName',
            );

        if (originalThumbnailUrl != null &&
            originalThumbnailUrl!.startsWith('http')) {
          imagesToDelete.add(originalThumbnailUrl!);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Thumbnail upload failed: $e')),
          );
        }
        return;
      }
    }

    List<String> finalAdditionalUrls = [];
    try {
      final productRepo = context.read<ProductRepository>();

      for (int i = 0; i < additionalImagesWebUrls.length; i++) {
        final currentUrl = additionalImagesWebUrls[i];
        final currentBytes = additionalImagesBytes[i];
        final currentName = additionalImagesFileNames[i];

        if (currentUrl.startsWith('http') && currentBytes.isEmpty) {
          finalAdditionalUrls.add(currentUrl);
        } else if (currentBytes.isNotEmpty) {
          final uploadedUrl = await productRepo.uploadProductImage(
            currentBytes,
            '${DateTime.now().millisecondsSinceEpoch}_$currentName',
          );
          finalAdditionalUrls.add(uploadedUrl);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Additional images upload failed: $e')),
        );
      }
      return;
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

    final updatedPlant = PlantModel(
      id: _editingPlantId!,
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
      thumbnailImg: finalThumbnailUrl,
      imageUrl: finalAdditionalUrls,
      description: descriptionController.text.trim(),
      careGuide: careGuideData,
      isActive: isActive,
    );

    for (String urlToDelete in imagesToDelete) {
      await context.read<ProductRepository>().deleteProductImage(urlToDelete);
    }

    imagesToDelete.clear();

    bloc.add(UpdateExistingProduct(updatedPlant));
  }

  void toggleActiveStatus(bool value) {
    _isActive = value;
    notifyListeners();
  }

  void clearForm() {
    _editingPlantId = null;
    _isActive = true;
    nameController.clear();
    descriptionController.clear();
    heightController.clear();
    minTempController.clear();
    maxTempController.clear();
    stockController.clear();
    maxStockController.clear();
    priceController.clear();
    lightController.clear();
    waterController.clear();
    humidityController.clear();
    soilController.clear();
    petSafetyController.clear();

    thumbnailBytes = null;
    thumbnailFileName = null;
    thumbnailWebUrl = null;

    additionalImagesBytes.clear();
    additionalImagesFileNames.clear();
    additionalImagesWebUrls.clear();
    notifyListeners();
  }
}
