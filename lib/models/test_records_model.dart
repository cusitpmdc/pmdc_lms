class TestRecordModel {
  String testID;
  String subjectName;
  String testDate;
  String status;
  String isUrdu;

  TestRecordModel({
    required this.testID,
    required this.testDate,
    required this.isUrdu,
    required this.status,
    required this.subjectName,
  });

  factory TestRecordModel.fromJson(Map<String, dynamic> json) {
    return TestRecordModel(
      testID: json['testID'],
      testDate: json['Date'],
      isUrdu: json['isUrdu'],
      status: json['Status'],
      subjectName: json['SubjectName'],
    );
  }
}
