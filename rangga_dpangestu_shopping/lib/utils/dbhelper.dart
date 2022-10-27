import 'package:path/path.dart';
import 'package:rangga_dpangestu_shopping/models/list_items.dart';
import 'package:rangga_dpangestu_shopping/models/shopping_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  final String dbFileName = 'shopping.db';
  Database? db;

  //factory constructor 🔽
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  //factory contructor supaya tidak memanggil lagi

  Future<Database?> openDb() async {
    db ??= await openDatabase(
        join(await getDatabasesPath(),
            dbFileName), //jika null akan membuka database
        onCreate: ((db, version) {
      db.execute(//membuat table lists
          'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
      db.execute(//membuat table items
          'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))');
    }), version: version);
    return db;
  }

  Future testDb() async {
    db = await openDb();

    // await db!.execute('INSERT INTO lists VALUES(0, "FRUITS", 2)');
    // await db!.execute(
    //     'INSERT INTO items VALUES(0, 0, "Apples", "2 Kg", "Better if they are green")');

    // sudah di eksekusi 🔼

    List lists = await db!.rawQuery('SELECT * FROM lists');
    List items = await db!.rawQuery('SELECT * FROM items');

    print(lists.toString());
    print(items.toString());
  }

  Future<int> insertList(ShoppingList shoppingList) async {
    int id = await db!.insert('lists', shoppingList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  Future<int> insertItem(ListItem listItems) async {
    int id = await db!.insert('items', listItems.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('lists');
    return List.generate(maps.length, (index) {
      return ShoppingList(
          id: maps[index]['id'],
          name: maps[index]['name'],
          priority: maps[index]['priority']);
    });
  }

  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps = await db!.query('items',
        where: 'idList = ?',
        whereArgs: [idList]); //where args untuk mengeset tanda tanya
    return List.generate(maps.length, (index) {
      return ListItem(
          id: maps[index]['id'],
          idList: maps[index]['idList'],
          name: maps[index]['name'],
          quantity: maps[index]['quantity'],
          note: maps[index]['note']);
    });
  }

  Future<int> deleteList(ShoppingList list) async {
    int result =
        await db!.delete("items", where: "idList = ?", whereArgs: [list.id]);
    result = await db!.delete("lists", where: "id = ?", whereArgs: [list.id]);
    return result;
  }

  Future<int> deleteItem(ListItem item) async {
    int result =
        await db!.delete("items", where: "id = ?", whereArgs: [item.id]);

    return result;
  }
}
