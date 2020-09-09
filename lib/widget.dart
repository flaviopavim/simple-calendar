import 'package:flutter/material.dart';

round() {
  return BorderRadius.only(
    topLeft: Radius.circular(3.0),
    topRight: Radius.circular(3.0),
    bottomLeft: Radius.circular(3.0),
    bottomRight: Radius.circular(3.0),
  );
}

input(t, c) {
  return Column(
    children: <Widget>[
      Column(
        children: <Widget>[
          Align(alignment:Alignment.centerLeft,child:Text(t,style:TextStyle(fontSize:18.0))),
          TextFormField(
            controller: c,
          ),
        ],
      ),
      Container(height: 15)
    ],
  );
}