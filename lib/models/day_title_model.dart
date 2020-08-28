class DayTitleModel {
  // Database id (key)
  int id;
  int idWeekTitle;
  String dayNum;
  String currentDay;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional title parameters
  DayTitleModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.idWeekTitle,
    this.dayNum,
    this.currentDay,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'idWeekTitle': idWeekTitle,
      'dayNum': dayNum,
      'currentDay': currentDay,
    };
  }
}
