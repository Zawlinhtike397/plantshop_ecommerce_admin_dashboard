import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/sizes.dart';

class TableHeader extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;

  final bool showLeftWidget;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;

  const TableHeader({
    super.key,
    this.onPressed,
    this.buttonText = 'Add',
    this.searchController,
    this.searchOnChanged,
    this.showLeftWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: MediaQuery.of(context).size.width >= Sizes.desktopScreenSize
              ? 3
              : 1,
          child: showLeftWidget
              ? Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8.0),
                      ),
                      onPressed: onPressed,
                      child: Text(buttonText),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
        Expanded(
          flex: MediaQuery.of(context).size.width >= Sizes.desktopScreenSize
              ? 2
              : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal),
              hintText: 'Search here',
            ),
          ),
        ),
      ],
    );
  }
}
