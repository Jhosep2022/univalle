import 'package:flutter/material.dart';
import 'package:madamecosmetics/widgets/DetailsWidget.dart';

class ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.8,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < 8; i++)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Image.asset(
                      "lib/img/${i + 1}.jpg",
                      height: 200,
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Crema",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Para el cuidado de la piel, ¡compre ya!",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "\$55",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}