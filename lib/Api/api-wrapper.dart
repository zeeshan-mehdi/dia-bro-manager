import '../constants.dart';

class ApiWrapper{



  static createPatientJson(givenName,familyName,gender,dob,password){

    final id = familyName + password;



    return {
      "resourceType": "Patient",
      "identifier": [
        {
          "system": "http://nema.org/examples/patients",
          "value": "$id"
        }
      ],
      "active": true,
      "name": [
        {
          "use": "official",
          "family": familyName,
          "given": [
              givenName
            ]
      }
      ],
      "gender": gender,
      "birthDate": dob,
      "deceasedBoolean": false,
    };
  }

  static createMedicationJson(medication,dosage,duration,durationUnit,frequency,type,patientId){
    return {
      "dateAsserted": DateTime.now().toString(),
      "dosage": [
        {
          "doseAndRate": [
            {
              "dose": medication,
              "doseQuantity": {dosage},
              "doseRange": {},
              "id": "string",
              "rate": "string",
              "rateQuantity": {duration},
              "rateRange": {frequency},
              "rateRatio": {},
              "type": {type}
            }
          ],
        }
      ],
      "effectiveDateTime": DateTime.now().add(Duration(days: getNumberOfDays(duration,durationUnit))),
      "effectivePeriod": {
        "end": DateTime.now().add(Duration(days: getNumberOfDays(duration,durationUnit))),
        "start": DateTime.now().toString()
      },
      "medication": "diabetic",
      "status": "completed",
      "subject": {
        "display": "string",
        "id": patientId,
        "identifier": {},
        "type": "string"
      }
    };
  }

  static createExaminationJson(medication,dosage,duration,durationUnit,frequency,type,patientId){
    return {
      "dateAsserted": DateTime.now().toString(),
      "dosage": [
        {
          "doseAndRate": [
            {
              "dose": medication,
              "doseQuantity": {dosage},
              "doseRange": {},
              "id": "string",
              "rate": "string",
              "rateQuantity": {duration},
              "rateRange": {frequency},
              "rateRatio": {},
              "type": {type}
            }
          ],
        }
      ],
      "effectiveDateTime": DateTime.now().add(Duration(days: getNumberOfDays(duration,durationUnit))),
      "effectivePeriod": {
        "end": DateTime.now().add(Duration(days: getNumberOfDays(duration,durationUnit))),
        "start": DateTime.now().toString()
      },
      "medication": "diabetic",
      "status": "completed",
      "subject": {
        "display": "string",
        "id": patientId,
        "identifier": {},
        "type": "string"
      }
    };
  }




}