class SetModel {
  // Database id (key)
  int id;
  int idExerciseGroupTitle;
  String setNumber;
  String percentage;
  String reps;
  int repMaxId;
  String completed;
  String prSet;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional title parameters
  SetModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.idExerciseGroupTitle,
    this.setNumber,
    this.percentage,
    this.reps,
    this.repMaxId,
    this.completed,
    this.prSet,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'idExerciseGroupTitle': idExerciseGroupTitle,
      'setNumber': setNumber,
      'percentage': percentage,
      'reps': reps,
      'repMaxId': repMaxId,
      'completed': completed,
      'prSet': prSet,
    };
  }
}
