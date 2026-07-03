import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/product_media_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class ProductMediaWidget extends StatelessWidget {
  final VoidCallback? onPickThumbnail;
  final Uint8List? thumbnailBytes;
  final String? thumbnailWebUrl;

  final VoidCallback? onPickImages;
  final List<Uint8List>? additionalImageBytes;
  final List<String>? additionalImagesWebUrls;
  final Function(int index)? onRemoveAdditionalImage;

  const ProductMediaWidget({
    super.key,
    this.onPickThumbnail,
    this.thumbnailBytes,
    this.onPickImages,
    this.additionalImageBytes,
    this.thumbnailWebUrl,
    this.additionalImagesWebUrls,
    this.onRemoveAdditionalImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final providerState = context.watch<ProductProvider>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColor.borderColor),
        color: isDarkMode ? AppColor.dark1 : AppColor.white,
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25.0,
        children: [
          Text(
            'Product Media',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ProductMediaCard(
            titleText: 'Thumbnail Image',
            buttonText: providerState.thumbnailBytes == null
                ? 'Add thumbnail image'
                : 'Change thumbnail image',
            isMultiImage: false,
          ),
          ProductMediaCard(
            titleText: 'Additional Images',
            buttonText: 'Add additional images',
            isMultiImage: true,
          ),
        ],
      ),
    );
  }
}
