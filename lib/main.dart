import 'package:flutter/material.dart';
import 'package:flutter_multi_selection_list/GridItem.dart';

import 'Item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> _items;
  List<Item> _selectedItems;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  _loadList() {
    _items = List();
    _selectedItems = List();

    List.generate(20, (index) {
      _items.add(Item("Item $index"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GridView.builder(
        itemCount: _items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.56,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return GridItem(
            key: Key(_items[index].hashCode.toString()),
            item: _items[index],
            isSelected: (bool isSelected) {
              setState(() {
                if (isSelected) {
                  _selectedItems.add(_items[index]);
                } else {
                  _selectedItems.remove(_items[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    String title;

    if (_selectedItems.length == 0) {
      title = "Multi Selection";
    } else if (_selectedItems.length == 1) {
      title = "1 item selected";
    } else {
      title = "${_selectedItems.length} items selected";
    }

    return AppBar(
      title: Text(title),
      actions: <Widget>[
        _selectedItems.length < 1
            ? Container()
            : InkWell(
                onTap: () {
                  _deleteSelectedItems();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.delete),
                ),
              ),
      ],
    );
  }

  void _deleteSelectedItems() {
    setState(() {
      _items.removeWhere((item) => _selectedItems.contains(item));
      _selectedItems = List();
    });
  }
}
