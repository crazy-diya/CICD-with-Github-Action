import 'package:cicdgithubaction/home.dart';
import 'package:flutter/material.dart';

import '../enum.dart';
import 'flavor_config.dart';

Future<void> main() async {
  FlavorConfig(
    flavor: Flavor.live,
    color: Colors.amber,
    flavorValues: FlavorValues(),
  );
  runApp(const MyApp());
}
