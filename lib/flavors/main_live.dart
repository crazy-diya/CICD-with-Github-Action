import 'package:cicdgithubaction/main.dart';
import 'package:flutter/material.dart';

import '../enum.dart';
import 'flavor_config.dart';

Future<void> main() async {
  FlavorConfig(
    flavor: Flavor.LIVE,
    color: Colors.amber,
    flavorValues: FlavorValues(),
  );
  runApp(const MyApp());
}
