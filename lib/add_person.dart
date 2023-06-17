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
  void initState() {
    super.initState();
    pFunc.name = null;
    pFunc.age = null;
    pFunc.nameValue = false;
    pFunc.ageValue = false;
    pFunc.ageError = false;
  }

  @override
  void dispose() {
    pFunc.name = null;
    pFunc.age = null;
    pFunc.nameValue = false;
    pFunc.ageValue = false;
    pFunc.ageError = false;
    super.dispose();
  }

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
                      if (pFunc.isBlank(value)) {
                        setState(() {
                          pFunc.nameValue = false;
                        });
                      }
                      else {
                        setState(() {
                          pFunc.toNormalFieldName();
                          pFunc.name = value;
                          pFunc.nameValue = true;
                        });
                      }
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
                          pFunc.toNormalFieldAge();
                          pFunc.age = null;
                          pFunc.ageValue = false;
                          pFunc.ageError = false;
                        });
                      }
                      else {
                        setState(() {
                          try {
                            pFunc.toNormalFieldAge();
                            pFunc.age = int.parse(value);
                            pFunc.ageValue = true;
                            pFunc.ageError = false;
                            if (pFunc.containsSpace(value)) {
                              throw const FormatException();
                            }
                          }
                          catch (error) {
                            pFunc.ageFieldError();
                            pFunc.ageValue = false;
                            pFunc.ageError = true;
                          }
                        });
                      }
                    },
                  ),

                  OutlinedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      if (pFunc.isFieldFilled(pFunc.nameValue, pFunc.ageValue)) {
                        setState(() {
                          pFunc.addPersonData();
                          Navigator.of(context).pop();
                        });
                      }
                      else {
                        setState(() {
                          pFunc.checkField(pFunc.nameValue, pFunc.ageValue, pFunc.ageError);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}