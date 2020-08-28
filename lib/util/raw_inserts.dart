class RawInserts {
  String rawInserts({
    String idExerciseGroupTitle,
    String setNumber,
    String percentage,
    String reps,
    int repMaxId,
  }) {
    return 'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES($idExerciseGroupTitle, $setNumber, $percentage, $reps, $repMaxId,  "false", "false")';
  }

  String bbb({String setNum, int exerciseId}) {
    return rawInserts(
        idExerciseGroupTitle: '3',
        setNumber: setNum,
        percentage: '50',
        reps: '10',
        repMaxId: exerciseId);
  }

  String bbbPress({setNum}) {
    return bbb(setNum: setNum, exerciseId: 3);
  }
}
