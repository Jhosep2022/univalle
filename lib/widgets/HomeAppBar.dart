import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 235, 59, 1.0),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Madame Natural",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Spacer(),
          badges.Badge(
            badgeColor: Colors.red,
            padding: EdgeInsets.all(7),
            badgeContent: Text(
              "3",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "cartPage");
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
