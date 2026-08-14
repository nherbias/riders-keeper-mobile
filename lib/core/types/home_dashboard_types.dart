import 'package:flutter/material.dart';

class GarageSummaryData {
  const GarageSummaryData({
    required this.health,
    required this.total,
    required this.healthy,
    required this.overdue,
  });

  final int health;
  final int total;
  final int healthy;
  final int overdue;
}

class AttentionItemData {
  const AttentionItemData({
    required this.motorcycle,
    required this.detail,
    required this.status,
    required this.isCritical,
    this.title,
    this.icon = Icons.build,
    this.estimatedCost,
    this.serviceMethod,
    this.urgencyLabel,
  });

  final String motorcycle;
  final String detail;
  final String status;
  final bool isCritical;
  final String? title;
  final IconData icon;
  final String? estimatedCost;
  final String? serviceMethod;
  final String? urgencyLabel;
}

class PredictionItemData {
  const PredictionItemData({
    required this.motorcycle,
    required this.detail,
    required this.progress,
  });

  final String motorcycle;
  final String detail;
  final double progress;
}

class UpcomingItemData {
  const UpcomingItemData({
    required this.month,
    required this.day,
    required this.motorcycle,
    required this.service,
  });

  final String month;
  final String day;
  final String motorcycle;
  final String service;
}
