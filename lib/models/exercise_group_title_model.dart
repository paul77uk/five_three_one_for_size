class ExerciseGroupTitleModel {
  // Database id (key)
  int id;
  int idDayTitle;
  String exerciseGroupTitle;
  String currentExerciseGroup;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional title parameters
  ExerciseGroupTitleModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.idDayTitle,
    this.exerciseGroupTitle,
    this.currentExerciseGroup,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'idDayTitle': idDayTitle,
      'exerciseGroupTitle': exerciseGroupTitle,
      'currentExerciseGroup': currentExerciseGroup,
    };
  }
}
