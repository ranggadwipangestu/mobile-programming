import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_shopping/models/shopping_list.dart';
import 'package:rangga_dpangestu_shopping/utils/dbhelper.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(
      BuildContext context, ShoppingList shoppingList, bool isNew) {
    DbHelper dbHelper = DbHelper();
    if (!isNew) {
      txtName.text = shoppingList.name;
      txtPriority.text = shoppingList.priority.toString();
    }
    return AlertDialog(
      title: Text(isNew ? 'New Shopping List' : 'Edit Shopping List'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(hintText: 'Shopping List Name'),
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Shopping List Priority (1-3)'),
            ),
            ElevatedButton(
                onPressed: () {
                  shoppingList.name = txtName.text;
                  shoppingList.priority = int.parse(txtPriority.text);
                  //disimpan dulu
                  dbHelper.insertList(shoppingList);
                  Navigator.pop(context);
                },
                child: const Text('Save Shopping List'))
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
