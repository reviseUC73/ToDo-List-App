import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;
  IconData? icon;
  Color? color;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    this.icon,
    this.color,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }
}
