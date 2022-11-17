import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void add(List listTodo) {
    String stringTodo = jsonEncode(listTodo);
    prefs.setString("stringTodo", stringTodo);
  }

  static List get() {
    String stringTodo = prefs.getString("stringTodo") ?? "[]";
    return jsonDecode(stringTodo) ?? [];
  }

}
