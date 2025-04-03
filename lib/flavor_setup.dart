import 'flavor_config.dart';

void setupFlavor(String flavorString) {
  final flavor = _getFlavorFromString(flavorString);

  FlavorConfig(
    flavor: flavor,
    name: flavorString.toUpperCase(),
    apiBaseUrl: _getApiBaseUrl(flavor),
  );
}

Flavor _getFlavorFromString(String flavor) {
  switch (flavor) {
    case 'staging':
      return Flavor.test;
    case 'dev':
      return Flavor.dev;
    case 'prod':
    default:
      return Flavor.prod;
  }
}

String _getApiBaseUrl(Flavor flavor) {
  switch (flavor) {
    case Flavor.test:
      return "https://api.test.example.com";
    case Flavor.dev:
      return "https://api.dev.example.com";
    case Flavor.prod:
    default:
      return "https://api.example.com";
  }
}
