
import 'package:doctor_app/screens/examinations/create-examination.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Examination.dart';

class Examinations extends StatefulWidget {
  const Examinations({Key? key}) : super(key: key);

  @override
  _ExaminationsState createState() => _ExaminationsState();
}

class _ExaminationsState extends State<Examinations> {

  var examinations = [];

  @override
  void initState() {
    // TODO: implement initState

    getExaminations();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

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
                      "Examinations",
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
          ),...examinations.map<Widget>((medication) => ListTile(
            title: Text(medication.examination),
            subtitle: Text( medication.frequency),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Result "+ medication.result),
                Text("Next Visit "+ calculateNextTestDate(medication)),

              ],
            ),

          )).toList()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Medication',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add,),
        onPressed: ()async{
          var examination = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateExamination()));


          examinations.add(examination);

          if(mounted) {
            setState(() {});
          }



        },
      ),
    );
  }

  void getExaminations() {
      examinations = Examination.createSampleMedications();
  }
}
