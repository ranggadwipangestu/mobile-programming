import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_shopping/models/list_items.dart';
import 'package:rangga_dpangestu_shopping/models/shopping_list.dart';
import 'package:rangga_dpangestu_shopping/utils/dbhelper.dart';
import 'package:rangga_dpangestu_shopping/widgets/list_item_dialog.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  const ItemsScreen({Key? key, required this.shoppingList}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState(shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  late ShoppingList shoppingList;
  DbHelper dbHelper = DbHelper();
  List<ListItem> listItem = [];

  _ItemsScreenState(this.shoppingList);
  ListItemDialog dialog = ListItemDialog();

  @override
  Widget build(BuildContext context) {
    dbHelper.openDb();
    showData(shoppingList.id ?? -1);
    return Scaffold(
      appBar: AppBar(title: Text(shoppingList.name)),
      body: ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(listItem[index].name),
            onDismissed: (direction) {
              String strName = listItem[index].name;
              dbHelper.deleteItem(listItem[index]);
              setState(() {
                listItem.removeAt(index);
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('$strName deleted')));
            },
            child: ListTile(
              title: Text(listItem[index].name),
              subtitle: Text(
                  'Quantity : ${listItem[index].quantity} - Note : ${listItem[index].note}'),
              onTap: () {},
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((BuildContext context) =>
                          dialog.buildAlert(context, listItem[index], false)));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => dialog.buildAlert(
                    context,
                    ListItem(idList: shoppingList.id, name: '', quantity: ''),
                    true));
          },
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add)),
    );
  }

  Future showData(int idList) async {
    await dbHelper.openDb();
    listItem = await dbHelper.getItems(idList);
    setState(() {
      listItem = listItem;
    });
  }
}
