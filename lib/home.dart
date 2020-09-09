import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fn.dart';
import 'var.dart';
import 'widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  setData() async {
    var dec = jsonDecode(await toJava({
      "ref": "list",
    }));
    if (dec != null) {
      calendar = [];
      for (int i = 0; i < dec.length; i++) {
        String id = i.toString();
        calendar.add({
          "id": dec[id]["id"],
          "title": dec[id]["title"],
          "description": dec[id]["description"],
          "date": date(dec[id]["datetime"]),
          "time": time(dec[id]["datetime"]),
          "repeat": dec[id]["repeat"],
          "cycle": dec[id]["cycle"],
          "color": dec[id]["color"],
          "color1": dec[id]["color"] == ""
              ? Colors.grey
              : (dec[id]["color"] == "0"
                  ? Colors.red
                  : (dec[id]["color"] == "1"
                      ? Colors.purple
                      : (dec[id]["color"] == "2"
                          ? Colors.blue
                          : (dec[id]["color"] == "3"
                              ? Colors.green
                              : (dec[id]["color"] == "4"
                                  ? Colors.amber
                                  : (dec[id]["color"] == "5"
                                      ? Colors.orange
                                      : (Colors.grey))))))),
          "color2": dec[id]["color"] == ""
              ? Colors.grey
              : (dec[id]["color"] == "0"
                  ? Colors.redAccent
                  : (dec[id]["color"] == "1"
                      ? Colors.purpleAccent
                      : (dec[id]["color"] == "2"
                          ? Colors.blueAccent
                          : (dec[id]["color"] == "3"
                              ? Colors.greenAccent
                              : (dec[id]["color"] == "4"
                                  ? Colors.amberAccent
                                  : (dec[id]["color"] == "5"
                                      ? Colors.orangeAccent
                                      : (Colors.grey))))))),
        });
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    void editCalendar(id) {
      edit_id = id;
      Navigator.pop(context);
      Navigator.pushNamed(context, '/edit');
    }

    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scrollbar(
              child: ListView(shrinkWrap: true, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  if (calendar != null)
                    if (calendar.length == 0)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 20),
                          Text('Empty calendar',
                              style: TextStyle(fontSize: 33)),
                          Text('Click on + to add a new note',
                              style: TextStyle(fontSize: 18)),
                          Container(height: 20),
                        ],
                      )
                    else
                      for (int i = 0; i < calendar.length; i++)
                        if (calendar[i] != null)
                          Column(
                            children: <Widget>[
                              Stack(children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        //Container(height: 22.0),
                                        Container(
                                          color: calendar[i]['color2'] != ''
                                              ? calendar[i]['color2']
                                              : Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: round(),
                                                  color: Colors.white10,
                                                ),
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(height: 28.0),
                                                      Column(
                                                        children: <Widget>[
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  calendar[i][
                                                                          'date'] +
                                                                      ' ' +
                                                                      calendar[
                                                                              i]
                                                                          [
                                                                          'time'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      color: Colors
                                                                          .white))),
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  calendar[i][
                                                                      'description'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      color: Colors
                                                                          .white))),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: round(),
                                        color: calendar[i]['color1'] != ''
                                            ? calendar[i]['color1']
                                            : Colors.blueAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Text(calendar[i]['title'],
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white)),
                                      ),
                                    )),
                                Positioned(
                                  top: 4,
                                  right: (5 + 36).toDouble(),
                                  child: GestureDetector(
                                      onTap: () {
                                        editCalendar(i);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: round(),
                                          color: calendar[i]['color1'] != ''
                                              ? calendar[i]['color1']
                                              : Colors.blueAccent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.edit,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                                Positioned(
                                    top: 4,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        //showAlertDialog(context,i);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Delete",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              content: Text(
                                                  "Do you want to delete this task?",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Close",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // dismiss dial
                                                    setState(() {});
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Delete",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    toJava({
                                                      "ref": "del",
                                                      "id": calendar[i]["id"]
                                                    });
                                                    setData();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: round(),
                                          color: calendar[i]['color1'] != ''
                                              ? calendar[i]['color1']
                                              : Colors.blueAccent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.close,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ))
                              ]),
                              Container(height: 12.0),
                            ],
                          )
                ],
              ),
            ),
          ])),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editCalendar(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
