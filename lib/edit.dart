import 'package:flutter/material.dart';
import 'fn.dart';
import 'var.dart';
import 'widget.dart';

class Edit extends StatefulWidget {
  Edit({Key key}) : super(key: key);
  @override
  _Edit createState() => _Edit();
}

class _Edit extends State<Edit> {
  @override
  void initState() {
    super.initState();
    if (edit_id != null && edit_id >= 0) {
      controller_title.text = calendar[edit_id]['title'];
      controller_description.text = calendar[edit_id]['description'];
      controller_date.text = calendar[edit_id]['date'];
      controller_time.text = calendar[edit_id]['time'];
      color = calendar[edit_id]['color'] != null
          ? int.parse(calendar[edit_id]['color'])
          : 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Scrollbar(
          child: ListView(shrinkWrap: true, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              input('Title', controller_title),
              input('Description', controller_description),
              Row(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: input('Date', controller_date),
                ),
                Container(width: 15),
                Expanded(
                  flex: 1,
                  child: input('Time', controller_time),
                ),
              ]),
              Row(
                  children: List.generate(7, (i) {
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        color = i;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: color != i
                              ? Color(0x00000000)
                              : (i == 0
                                  ? Colors.redAccent
                                  : (i == 1
                                      ? Colors.purpleAccent
                                      : (i == 2
                                          ? Colors.blueAccent
                                          : (i == 3
                                              ? Colors.greenAccent
                                              : (i == 4
                                                  ? Colors.amberAccent
                                                  : (i == 5
                                                      ? Colors.orangeAccent
                                                      : (Colors.black45))))))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                color: i == 0
                                    ? Colors.red
                                    : (i == 1
                                        ? Colors.purple
                                        : (i == 2
                                            ? Colors.blue
                                            : (i == 3
                                                ? Colors.green
                                                : (i == 4
                                                    ? Colors.amber
                                                    : (i == 5
                                                        ? Colors.orange
                                                        : (Colors.grey)))))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: double.infinity, height: 26),
                                )),
                          ),
                        ),
                      )),
                );
              })),
              Container(height: 15),
              GestureDetector(
                  onTap: () async {
                    await toJava({
                      "ref": "edit",
                      "id": (edit_id != null) ? calendar[edit_id]['id'] : 0,
                      "title": controller_title.text,
                      "description": controller_description.text,
                      "datetime":
                          dateTime(controller_date.text, controller_time.text),
                      "color": color,
                    });
                    edit_id = null;
                    controller_title.text = "";
                    controller_description.text = "";
                    controller_date.text = "";
                    controller_time.text = "";
                    color = 0;
                    product = [];
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: round(),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ),
                  )),
              Container(height: 5),
              GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: round(),
                      color: Colors.black45,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Text('Back',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ),
                  ))
            ],
          ),
        )
      ]))
    ]));
  }
}