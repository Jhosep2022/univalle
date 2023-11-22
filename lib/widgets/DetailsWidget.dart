import 'package:flutter/material.dart';
import 'package:madamecosmetics/pages/HomePage.dart';

void main() => runApp(MyApp());

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double offerPrice;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.offerPrice,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmética Elegante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 68, 161, 224),
        scaffoldBackgroundColor: Color(0xFFECF0F1),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
          subtitle1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 14, 141, 227),
          ),
        ),
      ),
      home: ProductPage(
        product: Product(
          name: "Vincha Acolchada",
          description:
              "Experimenta la comodidad en su máxima expresión con nuestra vincha acolchada. ¡Descúbrelo ahora!",
          imageUrl: "lib/img/1.jpg",
          price: 100.0,
          offerPrice: 80.0,
        ),
      ),
    );
  }
}
class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 235, 59, 1.0),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 235, 59, 1.0),
                Colors.greenAccent,
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Reemplaza la página actual con la página de inicio existente
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.greenAccent,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    product.imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Precio:',
                    style: TextStyle(fontSize: 18.0, color: Colors.black54),
                  ),
                  Text(
                    '\$${product.price.toString()}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Oferta:',
                    style: TextStyle(fontSize: 18.0, color: Colors.black54),
                  ),
                  Text(
                    '\$${product.offerPrice.toString()}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2ECC71).withOpacity(0.8),
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Añadir al carrito',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
