
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madamecosmetics/models/Product.dart';
import 'package:madamecosmetics/pages/CartPage.dart';
import 'package:madamecosmetics/pages/create_category.dart';
import 'package:madamecosmetics/widgets/CategoriesWidget.dart';
import 'package:madamecosmetics/widgets/CustomSearch.dart';
import 'package:madamecosmetics/widgets/HomeAppBar.dart';
import 'package:madamecosmetics/widgets/ItemsWidget.dart';

import 'package:madamecosmetics/widgets/Product_Tile.dart';
import 'package:madamecosmetics/widgets/TechSupportWidget.dart';
import 'package:madamecosmetics/pages/CrudProductPage.dart';

class HomePage extends StatefulWidget {
 const HomePage({Key? key}) : super(key: key);

 @override
 State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 CustomSearch _customSearch = CustomSearch();
 List<Product> productMenu = [];
 String message = "";
 bool isLoading = true;

 @override
 void initState() {
    super.initState();
    fetchData();
 }

 Future<void> fetchData() async {
  var url = Uri.parse("http://192.168.1.10/mysql/SelectProduct.php");
  try {
    final response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final productList = data.map((item) => Product.fromJson(item)).whereType<Product>().toList();

      setState(() {
        productMenu = productList;
        isLoading = false;
      });
    } else {
      print("Error al obtener datos de la API. Código de estado: ${response.statusCode}");
      setState(() {
        isLoading = false;
        message = "Error al obtener datos: ${response.statusCode}";
      });
    }
  } catch (e) {
    print("Ocurrió un error: $e");
    setState(() {
      isLoading = false;
      message = "Error al conectar con el servidor: $e";
    });
  }
}

 void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Puedes cambiar el color si lo deseas
      ),
    );
 }

 void navigateToFormScreen() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => TechnicalSupport(),
      ),
    )
        .then((_) {
      setState(() {
        _selectedIndex = 0;
      });
    });
 }

 void navigateToCartScreen() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    )
        .then((_) {
      setState(() {
        _selectedIndex = 0;
      });
    });
 }

 int _selectedIndex = 0;

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                 margin: EdgeInsets.symmetric(horizontal: 15),
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 height: 50,
                 decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                 ),
                 child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showSearch(
                                context: context, delegate: _customSearch);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Buscar Aquí...",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showSearch(context: context, delegate: _customSearch);
                        },
                        child: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.black,
                        ),
                      ),
                    ],
                 ),
                ),
                Container(
                 margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                 child: Row(
                    children: [
                      Text(
                        "Categorias",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                          );
                        },
                        child: Text('Agregar nueva categoría'),
                      ),
                    ],
                 ),
                ),
                CategoriesWidget(),
                Container(
                 alignment: Alignment.centerLeft,
                 margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                 child: Text(
                    "Mejor Vendido",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                 ),
                ),
                Container(
                 height: 200,
                 child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productMenu.length,
                          itemBuilder: (context, index) => ProductTile(
                            product: productMenu[index],
                          ),
                        ),
                ),
                const SizedBox(height: 15),
                Container(
                 alignment: Alignment.centerLeft,
                 margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                 child: Text(
                    "Lista Productos",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                 ),
                ),
                ItemsWidget(
                 product: null,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (_selectedIndex == 1) {
            navigateToCartScreen();
          }

          if (_selectedIndex == 2) {
            navigateToFormScreen();
          }
        },
        height: 70,
        color: Colors.green,
        index: _selectedIndex,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla AddItemScreen al presionar el botón
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
 }
}
