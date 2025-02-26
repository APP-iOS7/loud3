import 'package:flutter/material.dart';

class Listmodel {
  final DateTime createdAt;
  final String title;
  final String subTitle;
  final String imagePath;
  final Map<String, WidgetBuilder> route;

  Listmodel({
    required this.createdAt,
    required this.title,
    required this.subTitle,
    required this.route,
    String? imagePath,
  }) : imagePath = imagePath ?? "none";
}
