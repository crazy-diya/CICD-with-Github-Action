import 'package:flutter/material.dart';

import '../enum.dart';
import '../string_util.dart';


class FlavorValues {
  FlavorValues();
}

class FlavorConfig {
  final Flavor? flavor;
  final String? name;
  final Color? color;
  final FlavorValues? flavorValues;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color color = Colors.blue,
      required FlavorValues flavorValues}) {
    _instance ??= FlavorConfig._internal(
      flavor,
      StringUtils.enumName(flavor.toString()),
      color,
      flavorValues,
    );
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.flavorValues);

  static FlavorConfig? get instance {
    return _instance;
  }

  static bool isLive() => _instance?.flavor == Flavor.live;

  static bool isDevelopment() => _instance?.flavor == Flavor.dev;

  static bool isQA() => _instance?.flavor == Flavor.qa;
}