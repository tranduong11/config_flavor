import 'package:flutter/material.dart';

import 'app.dart';
import 'flavor_setup.dart';

void main() {
  const String flavorString = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  setupFlavor(flavorString);
  runApp(const MyApp());
}
