import 'package:dio/dio.dart';
import 'package:doctor_app/Api/api-wrapper.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Api{
  final baseUrl = 'https://fhir.nasfjq8u71h8.static-test-account.isccloud.io';

  final apiKey = '1gQBs8CG2F1uPodxxUF0T7s5SwOWhqAZ4LGwZPAs';
  var dio;

  Api(){
    dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["x-api-key"] = "$apiKey";
  }


  createPatient(givenName, familyName, gender, dob, password) async{
    final jsonBody = ApiWrapper.createPatientJson(givenName, familyName, gender, dob, password);

    Map data = jsonBody;
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse("https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/Patient"),
        headers: {"Content-Type": "application/json",'x-api-key':apiKey},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;


  }

  getPatientById(familyName,password)async{
    var id = familyName + password;
    var response = await http.get(Uri.parse('https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/Patient?identifier=$id'),headers: {"Content-Type": "application/json",'x-api-key':apiKey},);

    return response;
  }

  createMedication(medication, dosage, duration, durationUnit, frequency, type,)async{
    final prefs = await SharedPreferences.getInstance();


    String patientId = prefs.getString('id')??'';

    final jsonBody = ApiWrapper.createMedicationJson(medication, dosage, duration, durationUnit, frequency, type, patientId);

    var response = await http.post(Uri.parse("https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/MedicationStatement"),
        headers: {"Content-Type": "application/json",'x-api-key':apiKey},
        body: jsonBody
    );

    return response;

  }

  createExamination(medication, dosage, duration, durationUnit, frequency, type,)async{
    final prefs = await SharedPreferences.getInstance();


    String patientId = prefs.getString('id')??'';

    final jsonBody = ApiWrapper.createExaminationJson(medication, dosage, duration, durationUnit, frequency, type, patientId);

    var response = await http.post(Uri.parse("https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/Examination"),
        headers: {"Content-Type": "application/json",'x-api-key':apiKey},
        body: jsonBody
    );

    return response;

  }

  getMedicationStatementsByPatientId()async{
    final prefs = await SharedPreferences.getInstance();


    String patientId = prefs.getString('id')??'';

    var response = await http.get(Uri.parse('https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/MedicationStatement?pationt=$patientId'),headers: {"Content-Type": "application/json",'x-api-key':apiKey},);

    return response;

  }


  getExaminationStatementsByPatientId()async{
    final prefs = await SharedPreferences.getInstance();

    String patientId = prefs.getString('id')??'';

    var response = await http.get(Uri.parse('https://fhir.nasfjq8u71h8.static-test-account.isccloud.io/ExaminationStatement?pationt=$patientId'),headers: {"Content-Type": "application/json",'x-api-key':apiKey},);

    return response;

  }







}