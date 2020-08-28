class RepMaxModel {
  // Database id (key)
  int id;
  String lift;
  String repMax;
  String trainingMax;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional lift parameters
  RepMaxModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.lift,
    this.repMax,
    this.trainingMax,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'lift': lift,
      'repMax': repMax,
      'trainingMax': trainingMax,
    };
  }
}
