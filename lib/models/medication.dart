enum MedicationTableKeys {
  id,
  name,
  description,
  year,
  month,
  day,
  hour,
  minute
}

class Medication {
  late int id;
  late String name;
  late String description;
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;

  Medication();

  static const tableName = 'medication';

  Medication.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap[MedicationTableKeys.id.name];
    name = rowMap[MedicationTableKeys.name.name];
    description = rowMap[MedicationTableKeys.description.name];
    year = rowMap[MedicationTableKeys.year.name];
    month = rowMap[MedicationTableKeys.month.name];
    day = rowMap[MedicationTableKeys.day.name];
    hour = rowMap[MedicationTableKeys.hour.name];
    minute = rowMap[MedicationTableKeys.minute.name];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map[MedicationTableKeys.name.name] = name;
    map[MedicationTableKeys.description.name] = description;
    map[MedicationTableKeys.year.name] = year;
    map[MedicationTableKeys.month.name] = month;
    map[MedicationTableKeys.day.name] = day;
    map[MedicationTableKeys.hour.name] = hour;
    map[MedicationTableKeys.minute.name] = minute;
    return map;
  }
}
