// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectOptionItem {
  String? key;
  String? value;
  dynamic data;

  SelectOptionItem({
    required this.key,
    required this.value,
    required this.data,
  });

  SelectOptionItem copyWith({
    String? key,
    String? value,
    dynamic data,
  }) {
    return SelectOptionItem(
      key: key ?? this.key,
      value: value ?? this.value,
      data: data ?? this.data,
    );
  }
}
