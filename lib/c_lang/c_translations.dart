import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_lang/en_us.dart';
import 'package:quan_ly_ban_hang/c_lang/vi_vn.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'vi_VN': vi};
}
