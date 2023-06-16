import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  Person({
    required this.name,
    required this.age,
  });
}
