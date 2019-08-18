import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.library_books,
            color: Colors.grey,
          ),
          Icon(
            Icons.search,
            color: Colors.grey[850],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0.1
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.alarm,
            color: Colors.grey,
          ),
          Icon(
            Icons.chat,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
