import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data.dart';
import 'add_person.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter <Person> (PersonAdapter());
  await Hive.openBox <Person> ("personData");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      scrollBehavior: CustomScroll(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State <HomePage> createState() => _HomePageState();
}

class _HomePageState extends State <HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box <Person> ("personData").listenable(),
        builder: (context, Box <Person> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No Data"),
            );
          }
          else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Person? currPerson = box.getAt(index);
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) {
                          return AlertDialog(
                            content: Text("Are you sure want to delete ${currPerson.name}?"),
                            actions: [
                              ElevatedButton(
                                child: const Text("No"),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),

                              ElevatedButton(
                                child: const Text("Yes"),
                                onPressed: () {
                                  box.deleteAt(index);
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text("Name: ${currPerson!.name}"),
                          const SizedBox(height: 5),
                          Text("Age: ${currPerson.age.toString()}"),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPerson()));
        },
        child: const Icon(Icons.add),
      )
    );  
  }
}

class CustomScroll extends MaterialScrollBehavior {
  @override

  Set <PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
  };
}