import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

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

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Mode: ${FlavorConfig.instance.name}")),
//       body: Column(
//         children: [
//           Center(
//             child: Text('API URL: ${FlavorConfig.instance.apiBaseUrl}'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentIconName = "primary";

  @override
  void initState() {
    super.initState();
    _loadCurrentIcon();
  }

  void _loadCurrentIcon() async {
    String? iconName = await FlutterDynamicIcon.getAlternateIconName();
    setState(() {
      currentIconName = iconName ?? "primary";
    });
  }

  Future<void> _changeIcon(String iconName) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(iconName);
        _loadCurrentIcon();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Icon changed to $iconName")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to change icon")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mode: ${FlavorConfig.instance.name}")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('API URL: ${FlavorConfig.instance.apiBaseUrl}')),
          const SizedBox(height: 20),
          Text('Current Icon: $currentIconName'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _changeIcon("test_icon"),
            child: const Text("Set Test Icon"),
          ),
          ElevatedButton(
            onPressed: () => _changeIcon("dev_icon"),
            child: const Text("Set Dev Icon"),
          ),
          ElevatedButton(
            onPressed: () => _changeIcon("prod_icon"),
            child: const Text("Set Prod Icon"),
          ),
          ElevatedButton(
            onPressed: () => _changeIcon(''),
            child: const Text("Restore Default Icon"),
          ),
        ],
      ),
    );
  }
}
