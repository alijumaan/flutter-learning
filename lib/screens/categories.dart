import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  final _formkey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    http.Response response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future updateCategory() async {
    final form = _formkey.currentState;

    if (!form!.validate()) {
      return;
    }

    String uri ='http://10.0.2.2:8000/api/categories/' + selectedCategory.id.toString();

    await http.put(
        Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({ 'name': categoryNameController.text })
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: FutureBuilder<List<Category>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data![index];
                return ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      selectedCategory = category;
                      categoryNameController.text = category.name;
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                              key: _formkey,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  controller: categoryNameController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Enter category name';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Category name'),
                                ),
                                ElevatedButton(
                                    onPressed: () => updateCategory(),
                                    child: const Text('Update'))
                              ]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // return const Text('Something went wrong!');
            return Text(snapshot.error.toString());
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
