import 'package:flutter/material.dart';
import 'package:madamecosmetics/models/CartItem.dart';
import 'package:url_launcher/url_launcher.dart';

class CartBottomNavBar extends StatefulWidget {
  final double total;
  final List<CartItem> cartItems;

  CartBottomNavBar({required this.total, required this.cartItems});

  @override
  _CartBottomNavBarState createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 150,
          color: Color.fromARGB(255, 230, 219, 126),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${widget.total}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  _launchWhatsApp();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchWhatsApp() async {
    final phoneNumber = "+59177961504"; // Número de teléfono de WhatsApp
    final message = _buildWhatsAppMessage();
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _buildWhatsAppMessage() {
    String message = "Hola! Me interesa comprar:\n";

    for (var cartItem in widget.cartItems) {
      message += "-${cartItem.quantity} ${cartItem.title} \n";
    }

    message += "\n Total: \$${widget.total}";

    return message;
  }
}
