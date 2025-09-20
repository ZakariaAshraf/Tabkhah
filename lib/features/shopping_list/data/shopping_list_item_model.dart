class ShoppingListItem {
  final String name;
  final String measure;
  bool isChecked;

  ShoppingListItem({
    required this.name,
    required this.measure,
    this.isChecked = false,
  });

  factory ShoppingListItem.fromMap(Map<String, dynamic> map) {
    return ShoppingListItem(
      name: map['name'] ?? '',
      measure: map['measure'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'measure': measure,
      'isChecked': isChecked,
    };
  }
}
