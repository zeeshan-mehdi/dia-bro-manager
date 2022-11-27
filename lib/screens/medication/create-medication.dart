
import 'package:doctor_app/Api/api.dart';
import 'package:doctor_app/models/Medication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';
import '../auth/components/sign_up_form.dart';

class CreateMedication extends StatefulWidget {
  const CreateMedication({Key? key}) : super(key: key);

  @override
  _CreateMedicationState createState() => _CreateMedicationState();
}

class _CreateMedicationState extends State<CreateMedication>  with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  late String _medication;
  String _dose = '1';
  // Step 1.
  String dropdownValue = 'Tablets';

  String frequencyValue= '1x/day';
// Step 2.

  String durationValue= '1';


  String durationUnit= 'days';


  String? _doseForm;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding * 2),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Icon(Icons.arrow_back_ios,color:  Theme.of(context)
                          .textTheme
                          .headline5!.color!.withOpacity(0.7),),
                          onTap: ()=>Navigator.of(context).pop(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Add Examination",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontWeight: FontWeight.bold,color: Theme.of(context)
                                  .textTheme
                                  .headline5!.color!.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: defaultPadding * 2),
                  TextFieldName(text: "Examination"),
                  TextFormField(


                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "e.g ABCD Capsule",
                      border: InputBorder.none,
                     // focusedBorder: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      disabledBorder: InputBorder.none,),
                    validator: RequiredValidator(errorText: "Medication is required"),
                    onSaved: (medication) => _medication = medication!,
                  ),
                 const SizedBox(height: defaultPadding),
                  TextFieldName(text: "Dosage"),

                  Row(children: [
                    Expanded(
                      child: DropdownButton<String>(
                        // Step 3.
                        value: _dose,
                        isExpanded: true,
                        // Step 4.
                        items: <String>['1','2','3','4','5','6','7','8','9','10']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,

                            child: Text(
                              value,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            _dose = newValue!;
                          });
                        },
                      ),
                    ),
                    DropdownButton<String>(
                      // Step 3.
                      value: dropdownValue,
                      isExpanded: false,
                      // Step 4.
                      items: <String>['Tablets','mg']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,

                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),

                  ],),


                  const SizedBox(height: defaultPadding),

                  TextFieldName(text: "Frequency"),
                  DropdownButton<String>(
                    // Step 3.
                    value: frequencyValue,
                    isExpanded: true,
                    // Step 4.
                    items: <String>['1x/day', '2x/day','3x/day','4x/day','5x/day','6x/day','7x/day','8x/day']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,

                        child: Text(
                          value,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        frequencyValue = newValue!;
                      });
                    },
                  ),

                  TextFieldName(text: "Duration"),

                  Row(children: [
                    Expanded(
                      child: DropdownButton<String>(
                        // Step 3.
                        value: durationValue,
                        isExpanded: true,
                        // Step 4.
                        items: <String>['1','2','3','4','5','6','7','8','9','10']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,

                            child: Text(
                              value,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            durationValue = newValue!;
                          });
                        },
                      ),
                    ),
                    DropdownButton<String>(
                      // Step 3.
                      value: durationUnit,
                      isExpanded: false,
                      // Step 4.
                      items: <String>['days','weeks','months','years']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,

                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          durationUnit = newValue!;
                        });
                      },
                    ),

                  ],),

                  SizedBox(height: 50,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Sign up form is done
                          // It saved our inputs
                          _formKey.currentState!.save();
                          //  Sign in also done


                          setState(() {
                            _loading = true;
                          });


                          Medication medication = new Medication(_medication, _dose, _doseForm??'', frequencyValue, durationValue, durationUnit);


                          await Future.delayed(Duration(milliseconds: 500)).then((value){});


                          Toast.show('New Medication Added Successfully!');

                          Navigator.of(context).pop(medication);


                          setState(() {
                            _loading = false;
                          });

                          // var api = Api();
                          //
                          // //medication, dosage, duration, durationUnit, frequency, type
                          //
                          // var response = await api.createMedication(_medication,_dose,durationValue,durationUnit,frequencyValue);
                          //
                          // if(response.statusCode == 201 || response.statusCode == 200|| response.statusCode == 202){
                          //
                          // }


                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),





              ],),
            ),),
          ),
        ),

        Center(child: _loading ? SpinKitSquareCircle(
          color: Theme.of(context).primaryColor,
          size: 50.0,
          controller: AnimationController( duration: const Duration(milliseconds: 1200), vsync: this),
        ):Container())
      ],
    );
  }
}
