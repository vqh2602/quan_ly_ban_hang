enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'OMIYAGE (dev)';
      case Flavor.prod:
        return 'OMIYAGE';
      default:
        return 'title';
    }
  }
}
