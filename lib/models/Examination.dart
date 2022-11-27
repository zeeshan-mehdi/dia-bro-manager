class Examination{
  String examination;
  String frequency;
  String result;//tablet or mg

  Examination(this.examination, this.frequency, this.result);


  static createSampleMedications(){
    var examinations = [];

    Examination examination  = Examination("Blood Pressure", "Once a month", "130/80");


    examinations.add(examination);
    examinations.add(examination);
    examinations.add(examination);
    examinations.add(examination);
    examinations.add(examination);

    return examinations;

  }
}