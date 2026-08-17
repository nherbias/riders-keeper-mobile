import 'package:flutter/material.dart';

enum ServiceRecordStatus { completed, inspected, recommended }

class ServiceRecordData {
  const ServiceRecordData({
    required this.title,
    required this.date,
    required this.odometerKm,
    required this.cost,
    required this.icon,
    required this.status,
    required this.year,
    required this.category,
  });

  final String title;
  final String date;
  final int odometerKm;
  final double cost;
  final IconData icon;
  final ServiceRecordStatus status;
  final int year;
  final String category;
}
