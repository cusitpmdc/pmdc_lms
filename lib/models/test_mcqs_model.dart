class TestViewMcqs {
  TestViewMcqs({
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.answer5,
  });
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String answer5;
  factory TestViewMcqs.fromJson(Map<String, dynamic> json) => TestViewMcqs(
      question: json['Question'],
      answer1: json['Answer1'],
      answer2: json['Answer2'],
      answer3: json['Answer3'],
      answer4: json['Answer4'],
      answer5: json['Answer5']);

  Map<String, dynamic> tojson() => {
        "Question": question,
        "Answer1": answer1,
        "Answer2": answer2,
        "Answer3": answer3,
        "Answer4": answer4,
        "Answer5": answer5,
      };
}
