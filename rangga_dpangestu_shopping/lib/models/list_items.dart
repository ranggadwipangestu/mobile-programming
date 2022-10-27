class ListItem {
  int? id;
  int? idList;
  late String name;
  late String quantity;
  late String note;

  ListItem(
      // constuctor membutuh kan this
      {this.id,
      required this.idList,
      required this.name,
      required this.quantity,
      this.note =
          ''}); //nilai awal karena tidak harus ada isi, tidak menggunakan required

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
      'note': note
    };
  }
}
