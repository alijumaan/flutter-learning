import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<String> categories = <String>[
    'Category 1',
    'Category 2',
    'Category 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Center(
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(categories[index], style: const TextStyle(color: Colors.white),)
                );
              }),
        ),
      ),
    );
  }
}
