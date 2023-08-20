
// ignore_for_file: file_names
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/config/config_dev.dart' as dev;
import 'package:quan_ly_ban_hang/config/config_prod.dart' as prod;
import 'package:quan_ly_ban_hang/flavors.dart';

ModuleConfig getConfig() {
  switch (F.name.toLowerCase()) {
    case "dev":
      return dev.Environment();
    case "prod":
      return prod.Environment();
    default:
      return dev.Environment();
  }
}
