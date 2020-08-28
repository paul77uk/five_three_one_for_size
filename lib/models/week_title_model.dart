class WeekTitleModel {
  // Database id (key)
  int id;
  int idProgramTitle;
  String weekNum;
  String currentWeek;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional title parameters
  WeekTitleModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.idProgramTitle,
    this.weekNum,
    this.currentWeek,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'idProgramTitle': idProgramTitle,
      'weekNum': weekNum,
      'currentWeek': currentWeek,
    };
  }
}
