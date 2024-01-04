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
        return 'UNIK (dev)';
      case Flavor.prod:
        return 'UNIK';
      default:
        return 'title';
    }
  }

}
