import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_shopping/models/shopping_list.dart';
import 'package:rangga_dpangestu_shopping/ui/items_screen.dart';
import 'package:rangga_dpangestu_shopping/utils/dbhelper.dart';
import 'package:rangga_dpangestu_shopping/widgets/shopping_list_dialog.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: ShoppingListWidget(),
      ),
    );
  }
}

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  DbHelper dbHelper = DbHelper();
  List<ShoppingList> shoppingList = [];

  late ShoppingListDialog shoppingListDialog;

  @override
  void initState() {
    shoppingListDialog = ShoppingListDialog();
    super.initState();
  }

  Future showData() async {
    await dbHelper.openDb();
    shoppingList = await dbHelper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });

    // ShoppingList shoppingList =
    //     ShoppingList(id: 0, name: 'Bakery', priority: 2);
    // int listId = await dbHelper.insertList(shoppingList);

    // ListItem listItems = ListItem(
    //     id: 0,
    //     idList: listId,
    //     name: 'Bread',
    //     quantity: '1',
    //     note: 'Prefer chocolate bread');
    // int itemId = await dbHelper.insertItem(listItems);

    // debugPrint('List Id :$listId');
    // debugPrint('Item Id : $itemId');
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List Rangga')),
      body: ListView.builder(
          itemCount: shoppingList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(shoppingList[index].name),
              onDismissed: (direction) {
                String strName = shoppingList[index].name;
                dbHelper.deleteList(shoppingList[index]);
                setState(() {
                  shoppingList.removeAt(index);
                });
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$strName deleted")));
              },
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(shoppingList[index].priority.toString()),
                ),
                title: Text(shoppingList[index].name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ItemsScreen(shoppingList: shoppingList[index]),
                      ));
                },
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return shoppingListDialog.buildDialog(
                            context, shoppingList[index], false);
                      },
                    );
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return shoppingListDialog.buildDialog(
                  context,
                  ShoppingList(
                    name: '',
                    priority: 0,
                  ),
                  false);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
