class ShoppingList {
  int? id;
  late String name;
  late int priority;

  ShoppingList({this.id, required this.name, required this.priority});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'priority': priority};
  }
}
