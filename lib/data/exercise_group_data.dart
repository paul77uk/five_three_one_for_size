class ExerciseGroupData {
  List<List<dynamic>> bbb(int dayOne, int dayTwo, int dayThree, int dayFour) {
    return [
      [dayOne, "Warm up"],
      [dayOne, "531"],
      [dayOne, "BBB"],
      [dayOne, "Chin-ups"],
      [dayTwo, "Warm up"],
      [dayTwo, "531"],
      [dayTwo, "BBB"],
      [dayTwo, "Hanging Leg Raise"],
      [dayThree, "Warm up"],
      [dayThree, "531"],
      [dayThree, "BBB"],
      [dayThree, "Dumbbell Row"],
      [dayFour, "Warm up"],
      [dayFour, "531"],
      [dayFour, "BBB"],
      [dayFour, "Leg Curl"],
    ];
  }

  List<List<dynamic>> dayData(int week) {
    return [
      [week, "Day 1"],
      [week, "Day 2"],
      [week, "Day 3"],
      [week, "Day 4"],
    ];
  }

  List<List<dynamic>> setWarmUpData(int index, int repMaxId) {
    return [
      [index, "1", "40", repMaxId],
      [index, "2", "50", repMaxId],
      [index, "3", "60", repMaxId],
    ];
  }

  List<List<dynamic>> set531Data(int day, int repMaxId) {
    return [
      [day, "1", "65", repMaxId],
      [day, "2", "75", repMaxId],
      [day, "3", "85", repMaxId],
      [day, "1", "65", repMaxId],
      [day, "2", "75", repMaxId],
      [day, "3", "85", repMaxId],
      [day, "1", "65", repMaxId],
      [day, "2", "75", repMaxId],
      [day, "3", "85", repMaxId],
      [day, "1", "65", repMaxId],
      [day, "2", "75", repMaxId],
      [day, "3", "85", repMaxId],
    ];
  }

  List<List<dynamic>> setBBBData(int day, int repMaxId) {
    return [
      [day, "1", repMaxId],
      [day, "2", repMaxId],
      [day, "3", repMaxId],
      [day, "1", repMaxId],
      [day, "2", repMaxId],
      [day, "3", repMaxId],
      [day, "1", repMaxId],
      [day, "2", repMaxId],
      [day, "3", repMaxId],
      [day, "1", repMaxId],
      [day, "2", repMaxId],
      [day, "3", repMaxId],
    ];
  }
}
