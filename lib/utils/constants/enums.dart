import 'package:flutter/material.dart';

enum ImageType { asset, network, memory, file }

enum PlantDisplayStatus {
  active('Active', Colors.green),
  inactive('Inactive', Colors.grey),
  outOfStock('Out of Stock', Colors.red),
  low('Low', Color.fromARGB(255, 237, 131, 93)),
  warning('Warning', Color(0xFFEAB308));

  final String label;
  final Color color;

  const PlantDisplayStatus(this.label, this.color);
}
