import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 247, 236, 135),
      padding: EdgeInsets.all(25),
      child: Row(children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Carrito",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Spacer(),
        Icon(
          Icons.more_vert,
          size: 30,
          color: Colors.white,
        )
      ]),
    );
  }
}
