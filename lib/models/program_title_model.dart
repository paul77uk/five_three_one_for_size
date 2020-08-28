class ProgramTitleModel {
  // Database id (key)
  int id;
  String title;
  String currentProgram;

// String - not all phone numbers are valid mathematical numbers

// Constructor with optional title parameters
  ProgramTitleModel(
// @required annotation makes sure that
// an optional parameter is actually passed in
    this.id,
    this.title,
    this.currentProgram,
  );

// Map with string keys and values of any type
  Map<String, dynamic> toMap() {
// Map literals are created with curly braces {}
    return {
      'id': (id == 0) ? null : id,
      'title': title,
      'currentProgram': currentProgram,
    };
  }
}
