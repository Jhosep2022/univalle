import 'package:flutter/material.dart';
import 'package:madamecosmetics/models/CartItem.dart';
import 'package:madamecosmetics/widgets/CartAppBar.dart';
import 'CartBottomNavBar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(title: "Producto 1", price: 55.0, quantity: 1),
    CartItem(title: "Producto 2", price: 25.0, quantity: 1),
    CartItem(title: "Producto 3", price: 10.0, quantity: 1),
  ];

  late double _total; // Declara _total

  @override
  void initState() {
    super.initState();
    _updateTotal(); // Llama a _updateTotal para calcular el total inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // AppBar del carrito
          CartAppBar(),

          Container(
            
            height: 700,
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
                for (var cartItem in cartItems)
                  Container(
                    height: 110,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: "",
                          groupValue: "",
                          activeColor: Colors.black,
                          onChanged: (index) {},
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 15),
                          child:
                              Image.asset("lib/img/1.jpg"), // Cambien la dirección 
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cartItem.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "\$${cartItem.price}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cartItems.remove(cartItem);
                                    _updateTotal(); // Actualizar el total al eliminar un producto
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cartItem.quantity++;
                                        _updateTotal(); // Actualizar el total al agregar un producto
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "${cartItem.quantity}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (cartItem.quantity > 1) {
                                          cartItem.quantity--;
                                        }
                                        _updateTotal(); // Actualizar el total al restar un producto
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
      height: 140,
      child: CartBottomNavBar(total: _total, cartItems: cartItems),
    )
    );
  }

  // Método para actualizar el total
  void _updateTotal() {
    _total = cartItems.fold(0, (prev, cartItem) => prev + (cartItem.price * cartItem.quantity));
  }
}

void main() {
  runApp(MaterialApp(home: CartPage()));
}
