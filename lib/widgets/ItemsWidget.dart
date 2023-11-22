import 'package:flutter/material.dart';
import 'package:madamecosmetics/widgets/DetailsWidget.dart';
import '../models/Product.dart' as OriginalProduct;

class ItemsWidget extends StatelessWidget {
  final OriginalProduct.Product? product;

  const ItemsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8, // Change this to the length of your product list
      itemBuilder: (context, index) {
        return GestureDetector(
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
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.yellow[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "-50%",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Image.asset(
                    "lib/img/${index + 1}.jpg",
                    height: 200,
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  product?.nameProduct ?? 'N/A',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  product?.description ?? 'N/A',
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
        );
      },
    );
  }
}
