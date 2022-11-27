
import 'package:doctor_app/models/Examination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';
import '../auth/components/sign_up_form.dart';

class CreateExamination extends StatefulWidget {
  const CreateExamination({Key? key}) : super(key: key);

  @override
  _CreateExaminationState createState() => _CreateExaminationState();
}

class _CreateExaminationState extends State<CreateExamination> with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  late String _examinationResult;

  bool _loading = false;

  String examination= 'Blood Pressure';

  String frequency= 'Every 3-6 months';


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
                              "Add Medication",
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
                  DropdownButton<String>(
                    // Step 3.
                    value: examination,
                    isExpanded: true,
                    // Step 4.
                    items: <String>['Blood Pressure', 'Eye Exam','Dental Exam','Brief Foot Exam','Complete Foot Exam','Influenza Vaccine',
                      'Smoking Cessation Counseling','BMI','Haemoglobin A1c','Triglyceride','Total Cholesterol','LDL Cholesterol',
                      'HDL Cholesterol','Albumin Urine Creatinine', 'Electrocardiogram','Treatment Objectives',
                      'Blood Glucose' , 'Healthy Diet', 'Physical Activity']
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
                        examination = newValue!;
                      });
                    },
                  ),
                  TextFieldName(text: "Frequency"),
                  DropdownButton<String>(
                  // Step 3.
                  value: frequency,
                  isExpanded: true,
                  // Step 4.
                  items: <String>['Every 3-6 months','Once a year']
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
                      frequency = newValue!;
                    });
                  },
                ),
                  TextFieldName(text: "Examination Result "),
                  TextFormField(

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "value of specified result e.g  for blood pressure 80/120",
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      disabledBorder: InputBorder.none,),
                    validator: RequiredValidator(errorText: "Examination Result is required"),
                    onSaved: (medication) => _examinationResult = medication!,
                  ),
                  const SizedBox(height: defaultPadding),


                  SizedBox(height: 50,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          // Sign up form is done
                          // It saved our inputs
                          _formKey.currentState!.save();
                          //  Sign in also done


                          setState(() {
                            _loading = true;
                          });


                          Examination examination1 = new Examination(examination,frequency,_examinationResult);


                          await Future.delayed(Duration(milliseconds: 500)).then((value){});


                          Toast.show('New Examination Added Successfully!');

                          Navigator.of(context).pop(examination1);


                          setState(() {
                            _loading = false;
                          });
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
