
import 'package:doctor_app/models/Medication.dart';
import 'package:doctor_app/screens/medication/create-medication.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../auth/sign_in_screen.dart';

class Medications extends StatefulWidget {
  const Medications({Key? key}) : super(key: key);

  @override
  _MedicationsState createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {

  var medications = [];

  @override
  void initState() {
    // TODO: implement initState
    getListOfMedications();
    super.initState();
  }

  getListOfMedications(){
    medications = Medication.createSampleMedications();
  }


  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [  const SizedBox(height: defaultPadding * 2) ,Center(
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
                    "Medications",
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
        ),...medications.map<Widget>((medication) => ListTile(
              title: Text(medication.medication),
              subtitle: Text(medication.dosage + " "+ medication.doseForm + " " + medication.frequency),
              trailing: Text("For "+ medication.duration+ " " + medication.durationUnit),
            )).toList()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Medication',
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add,),
          onPressed: ()async{
            var medication = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateMedication()));

            medications.add(medication);

            if(mounted) {
              setState(() {});
            }


          },
        ),
      ),
    );
  }
}
