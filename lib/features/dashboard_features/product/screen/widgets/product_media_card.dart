import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class ProductMediaCard extends StatelessWidget {
  final String titleText;
  final String buttonText;
  final bool isMultiImage;

  const ProductMediaCard({
    super.key,
    required this.titleText,
    required this.buttonText,
    this.isMultiImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final providerState = context.watch<ProductProvider>();

    Widget buildPickerBox() {
      return DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(10),
          dashPattern: [4, 2],
          strokeWidth: 1,
          color: AppColor.midGray,
          padding: EdgeInsets.all(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColor.gray : Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 120,
          height: 120,
          child: Center(
            child: GestureDetector(
              onTap: isMultiImage
                  ? providerState.pickAdditionalImages
                  : providerState.pickThumbnail,
              child: Icon(
                Iconsax.add_circle,
                size: 40,
                color: isDarkMode ? AppColor.white : AppColor.lightGray,
              ),
            ),
          ),
        ),
      );
    }

    final bool hasThumbnail =
        providerState.thumbnailBytes != null ||
        (providerState.thumbnailWebUrl != null &&
            providerState.thumbnailWebUrl!.isNotEmpty);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: AppColor.borderColor),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.0,
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              if (!isMultiImage) ...[
                hasThumbnail
                    ? Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image:
                                kIsWeb && providerState.thumbnailWebUrl != null
                                ? NetworkImage(providerState.thumbnailWebUrl!)
                                      as ImageProvider
                                : MemoryImage(providerState.thumbnailBytes!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : buildPickerBox(),
              ] else ...[
                if (providerState.additionalImagesBytes.isNotEmpty)
                  ...List.generate(providerState.additionalImagesBytes.length, (
                    index,
                  ) {
                    // final hasWebUrl =
                    //     kIsWeb &&
                    //     providerState.additionalImagesWebUrls != null &&
                    //     providerState.additionalImagesWebUrls.length > index;
                    final bytes = providerState.additionalImagesBytes[index];

                    final isNetworkImage =
                        bytes.isEmpty &&
                        providerState.additionalImagesWebUrls.length > index;

                    return Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColor.borderColor,
                              width: 0.5,
                            ),
                            image: DecorationImage(
                              image: isNetworkImage
                                  // hasWebUrl
                                  ? NetworkImage(
                                          providerState
                                              .additionalImagesWebUrls![index],
                                        )
                                        as ImageProvider
                                  : MemoryImage(
                                      bytes,
                                      // providerState
                                      //     .additionalImagesBytes![index],
                                    ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () =>
                                providerState.removeAdditionalImage(index),

                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                buildPickerBox(),
              ],
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              onPressed: isMultiImage
                  ? providerState.pickAdditionalImages
                  : providerState.pickThumbnail,
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
