import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;
  IconData? icon; // ไอคอนที่สุ่มได้
  Color? color; // สีที่สุ่มได้

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    this.icon,
    this.color,
  });

  // Factory constructor to parse JSON
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
