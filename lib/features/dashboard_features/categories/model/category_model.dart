import 'package:flutter/material.dart';

class CategoryModel {
  final String category;
  final double totalSales;
  final int soldCount;
  final Color color;

  CategoryModel({
    required this.category,
    required this.totalSales,
    required this.soldCount,
    required this.color,
  });
}
