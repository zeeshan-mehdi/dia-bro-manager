import 'package:doctor_app/models/Examination.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xFF6CD8D1);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.3),
  ),
);

// I will explain it later

getNumberOfDays(duration,durationUnit){
  if(durationUnit == 'days'){
    return int.parse(duration);
  }else if(durationUnit == 'weeks'){
    return int.parse(duration)* 7;
  }else if(durationUnit == 'months'){
    return int.parse(duration)* 30;
  }else if(durationUnit == 'years'){
    return int.parse(duration)* 30*12;
  }
  return int.parse(duration);
}

calculateNextTestDate(Examination examination){
  DateTime today = DateTime.now();

  var formatter = new DateFormat('yyyy-MM-dd');

  if(examination.frequency == 'Once a year'){
    return formatter.format(today.add(Duration(days: 364)));
  }else if(examination.frequency == 'Every 3-6 months'){
    return formatter.format(today.add(Duration(days: 30*3)));
  }

  return formatter.format(today.add(Duration(days: 1)));

}


const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);


