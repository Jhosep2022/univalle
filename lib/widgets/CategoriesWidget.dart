import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:madamecosmetics/models/Category.dart';
import 'package:madamecosmetics/pages/category_screen.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay categorías disponibles'));
        } else {
          List<Category> categories = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((Category category) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      // Suponiendo que tienes un campo 'id' en tu objeto Category
                      builder: (context) => CategoryScreen(categoryId: category.id),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category.nameCategory,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
Future<List<Category>> fetchCategories() async {
  var url = Uri.parse("http://192.168.1.10/mysql/CategoryInsert.php");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List categoriesJson = json.decode(response.body);
    return categoriesJson.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar las categorías');
  }
}