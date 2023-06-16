import 'package:flutter/material.dart';
import 'person_funtion.dart';

class AddPerson extends StatefulWidget {
  AddPerson({ Key? key }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State <AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: true,
                    initialValue: null,
                    decoration: pFunc.inputDecorationName,
                    onChanged: (value) {
                      setState(() {
                        if (pFunc.isBlank(value)) {
                          pFunc.nameValue = false;
                        }
                        else {
                          pFunc.name = value;
                          pFunc.nameValue = true;
                        }
                      });
                    },
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    initialValue: null,
                    decoration: pFunc.inputDecorationAge,
                    onChanged: (value) {
                      if (pFunc.isBlank(value)) {
                        setState(() {
                          pFunc.toNormalFieldAge(value);
                          pFunc.age = int.parse(value);
                          pFunc.ageValue = false;
                        });
                      }
                      else {
                        setState(() {
                          try {
                            pFunc.toNormalFieldAge(value);
                            pFunc.age = int.parse(value);
                            pFunc.ageValue = true;
                            if (pFunc.containsSpace(value)) {
                              throw const FormatException();
                            }
                          }
                          catch (error) {
                            pFunc.ageFieldError();
                            pFunc.ageValue = false;
                          }
                        });
                      }
                    },
                  ),

                  OutlinedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      setState(() {
                        if (pFunc.isAllFieldBlank(pFunc.nameValue, pFunc.ageValue)) {
                            pFunc.allFieldBlank();
                        }
                        else {
                          pFunc.addPersonData();
                          Navigator.of(context).pop();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}