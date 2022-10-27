import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_shopping/models/list_items.dart';
import 'package:rangga_dpangestu_shopping/utils/dbhelper.dart';

class ListItemDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildAlert(BuildContext context, ListItem item, bool isNew) {
    DbHelper dbHelper = DbHelper();
    dbHelper.openDb();
    if (!isNew) {
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    return AlertDialog(
      title: Text((isNew) ? 'New Shopping item ' : 'Edit Shopping Item'),
      content: SingleChildScrollView(
        child: Column(children: [
          TextField(
            controller: txtName,
            decoration: const InputDecoration(hintText: 'Item Name'),
          ),
          TextField(
            controller: txtQuantity,
            decoration: const InputDecoration(hintText: 'Quantity'),
          ),
          TextField(
            controller: txtNote,
            decoration: const InputDecoration(hintText: 'Note'),
          ),
          RaisedButton(
            onPressed: () {
              item.name = txtName.text;
              item.quantity = txtQuantity.text;
              item.note = txtNote.text;
              dbHelper.insertItem(item);
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text('Save Item'),
          )
        ]),
      ),
    );
  }
}
