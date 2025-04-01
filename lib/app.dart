import 'package:flutter/material.dart';

import 'flavor_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ${FlavorConfig.instance.name} Flavor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _getColorForFlavor(FlavorConfig.instance.flavor),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }

  Color _getColorForFlavor(Flavor flavor) {
    switch (flavor) {
      case Flavor.test:
        return Colors.green;
      case Flavor.dev:
        return Colors.orange;
      case Flavor.prod:
      default:
        return Colors.blue;
    }
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mode: ${FlavorConfig.instance.name}")),
      body: Center(child: Text('API URL: ${FlavorConfig.instance.apiBaseUrl}')),
    );
  }
}
