class Medication{
  String medication;
  String dosage;
  String doseForm;//tablet or mg
  String frequency;
  String duration;
  String durationUnit;

  Medication(this.medication, this.dosage, this.doseForm, this.frequency,
      this.duration, this.durationUnit);
  
  
  static createSampleMedications(){
    var medications = [];
    
    Medication medication  = Medication("Metformin", "1", "Tablets", "1x/day", "1", "month");


    medications.add(medication);
    // medications.add(medication);
    // medications.add(medication);
    // medications.add(medication);
    // medications.add(medication);

    return medications;
    
  }
}