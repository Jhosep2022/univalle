import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:madamecosmetics/models/Product.dart';
import 'package:madamecosmetics/pages/HomePage.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  final int categoryId;

  CategoryScreen({required this.categoryId});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Product>> futureProducts;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProductsByCategory();
  }

  Future<List<Product>> fetchProductsByCategory() async {
    var url = Uri.parse(
        "http://192.168.1.10/mysql/CategoryInsert.php?category_id=${widget.categoryId}");
    try {
      var response = await http.get(url);
      print('Response status: ${response.statusCode}'); // Add this line
      print('Response body: ${response.body}'); // Add this line
      if (response.statusCode == 200) {
        List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        // Log the response body for debugging
        print('Server error: ${response.body}');
        setState(() {
          errorMessage = 'Error al cargar productos: ${response.statusCode}';
        });
        return [];
      }
    } catch (e) {
      // Log the exception
      print('Exception: $e');
      setState(() {
        errorMessage = 'Error al conectar con el servidor';
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
        backgroundColor: Color.fromRGBO(255, 235, 59, 1.0), // Yellow
        leading: IconButton(
          icon: Icon(Icons.arrow_upward),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            // Display the error message if there is an error
            return Center(child: Text(errorMessage));
          } else {
            // Display the list of products
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];
                return buildProductItem(product);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildProductItem(Product product) {
    // Usa la imagen del producto o una imagen por defecto si está vacía
    String imageUrl = product.imageUrl.isNotEmpty
        ? product.imageUrl
        : 'url_de_tu_imagen_por_defecto';

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Aquí puedes agregar la lógica para manejar los toques en el elemento del producto
          // Por ejemplo, navegar a una pantalla de detalle del producto.
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Estira los elementos para llenar la tarjeta
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover, // Cubre todo el espacio de la caja
                  errorBuilder: (context, error, stackTrace) {
                    // Aquí manejas el error de carga de la imagen, mostrando una imagen por defecto
                    return Image.network('url_de_tu_imagen_por_defecto',
                        fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.nameProduct,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product.priceBase.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
