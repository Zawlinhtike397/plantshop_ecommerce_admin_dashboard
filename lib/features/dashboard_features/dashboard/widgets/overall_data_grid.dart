import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/overall_data_card.dart';

class OverallDataGrid extends StatelessWidget {
  const OverallDataGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        int approximateCount = 1;

        if (width >= 900) {
          approximateCount = 4;
        } else if (width >= 650) {
          approximateCount = 3;
        } else {
          approximateCount = 2;
        }

        double itemWidth =
            (width - ((approximateCount - 1) * 10)) / approximateCount;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: itemWidth,
              child: OverallDataCard(
                title: 'Total Orders',
                subTitle: '200',
                stats: 30,
                isDarkMode: isDarkMode,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: OverallDataCard(
                title: 'Customers',
                subTitle: '3500',
                stats: 10,
                isDarkMode: isDarkMode,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: OverallDataCard(
                title: 'Total Revenues',
                subTitle: '44,50000MMK',
                stats: 10,
                isDarkMode: isDarkMode,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: OverallDataCard(
                title: 'Average Order Value',
                subTitle: '300,00MMK',
                stats: 10,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        );
      },
    );
  }
}
