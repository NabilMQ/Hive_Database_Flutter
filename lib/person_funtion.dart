import 'package:flutter/material.dart';
import 'data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

mixin pFunc {
  static String? name;
  static int? age;
  static bool nameValue = false;
  static bool ageValue = false;
  static bool ageError = false;

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
    if (s == "" || s == null) {
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

  static void toNormalFieldAge() {
    inputDecorationAge = const InputDecoration(
      labelText: "Age",
    );
  }

  static void toNormalFieldName() {
    inputDecorationName = const InputDecoration(
      labelText: "Name",
    );
  }

  static void ageFieldError() {
    inputDecorationAge = const InputDecoration(
      labelText: "Age",
      errorText: "Fill with number only",
    );
  }

  static void checkField(bool a, bool b, bool c) {
    if (!a) {
      inputDecorationName = const InputDecoration(
        labelText: "Name",
        errorText: "Fill the field",
      );
    }

    if (!b && !c) {
      inputDecorationAge = const InputDecoration(
        labelText: "Age",
        errorText: "Fill the field",
      ); 
    }
  }

  static bool isFieldFilled(bool a, bool b) {
    if (a && b) {
      return true;
    }
    return false;
  }

}