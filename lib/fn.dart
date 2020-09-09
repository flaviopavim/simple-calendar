import 'package:flutter/services.dart';

const platform = const MethodChannel('channel');

Future<String> toJava(data) async {
  String r = "";
  try {
    r = await platform.invokeMethod('tojava', data);
  } on PlatformException catch (e) {
    print("toJava error: '${e.message}'.");
  }
  return r;
}

date(d) {
  try {
    var s = d.split(" ");
    var s2 = s[0].split("-");
    if (s2[2] != "") {
      return s2[2] + '/' + s2[1] + '/' + s2[0];
    } else {
      return "";
    }
  } catch (e) {
    return "";
  }
}

time(d) {
  try {
    var s = d.split(" ");
    return s[1];
  } catch (e) {
    return "";
  }
}

dateTime(d, t) {
  try {
    if (d != "" && t != "") {
      var s = d.split("/");
      return s[2] + '-' + s[1] + '-' + s[0] + ' ' + t;
    } else {
      return "";
    }
  } catch (e) {
    return "";
  }
}
