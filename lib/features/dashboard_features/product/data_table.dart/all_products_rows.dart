import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class AllProductsRows extends DataTableSource {
  final List<PlantModel> plants = [
    PlantModel(
      id: 1,
      name: 'Jade Plant',
      originalPrice: 3000,
      height: '20cm',
      category: 'Indoor Plant',
      stock: 500,
      maxStock: 1000,
      restockedAt: DateTime(2024, 7, 30),
      temperature: '20°C',
      pot: 'Ceramic',
      thumbnailImg:
          'https://images.unsplash.com/photo-1459156212016-c812468e2115',
      imageUrl: [],
      description: 'Beautiful indoor plant',
    ),

    PlantModel(
      id: 2,
      name: 'Cactus',
      originalPrice: 3000,
      height: '15cm',
      category: 'Succulent Plant',
      stock: 0,
      maxStock: 1000,
      restockedAt: DateTime(2024, 7, 30),
      temperature: '30°C',
      pot: 'Plastic',
      thumbnailImg:
          'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a',
      imageUrl: [],
      description: 'Easy to care cactus',
    ),
  ];

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  DataRow? getRow(int index) {
    if (index >= plants.length) return null;

    final plant = plants[index];
    final bool outOfStock = plant.stock <= 0;

    return DataRow2(
      cells: [
        /// NAME
        DataCell(
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  plant.thumbnailImg,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 46,
                      height: 46,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  plant.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),

        /// CATEGORY
        DataCell(Text(plant.category)),

        /// STOCK
        DataCell(Text('${plant.stock}')),

        /// DATE
        DataCell(Text(formatDate(plant.restockedAt))),

        /// PRICE
        DataCell(Text('${plant.originalPrice.toInt()} MMK')),

        /// STATUS
        DataCell(
          Text(
            outOfStock ? 'Out of Stock' : 'Active',
            style: TextStyle(
              color: outOfStock ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        /// ACTIONS
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_square, color: Color(0xFF3B82F6)),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.red),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.ios_share_outlined,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => plants.length;

  @override
  int get selectedRowCount => 0;
}
