import 'package:flutter/material.dart';
import 'data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

mixin pFunc {
  static String? name;
  static int? age;
  static bool nameValue = false;
  static bool ageValue = false;

  static InputDecoration inputDecorationName = const InputDecoration(
    labelText: "Name",
  );
  static InputDecoration inputDecorationAge = const InputDecoration(
    labelText: "Age",
  );

  static void addPersonData() {
    Box <Person> box = Hive.box <Person> ("personData");
    box.add(Person(name: name!, age: age!));
  }

  static bool isBlank(String s) {
    if (s == "") {
      return true;
    }
    return false;
  }

  static bool containsSpace(String s) {
    if (s.contains(" ")) {
      return true;
    }
    return false;
  }

  static void toNormalFieldAge(value) {
    inputDecorationAge = const InputDecoration(
      labelText: "Age",
    );
  }

  static void ageFieldError() {
    inputDecorationAge = const InputDecoration(
      labelText: "Age",
      errorText: "Fill with number only",
    );
  }

  static bool isAllFieldBlank(bool a, bool b) {
    if (a == false && b == false) {
      return true;
    }
    return false;
  }

  static void allFieldBlank() {
    inputDecorationName = const InputDecoration(
      labelText: "Name",
      errorText: "Fill the field",
    );
    inputDecorationAge = const InputDecoration(
      labelText: "Age",
      errorText: "Fill the field",
    ); 
  }
}