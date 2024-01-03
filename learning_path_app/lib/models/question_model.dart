class QuestionModel {
  int srNo;
  String question;
  String isHtmlTag;
  String quesType;
  String answer;

  QuestionModel({
    required this.srNo,
    required this.question,
    required this.isHtmlTag,
    required this.quesType,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      srNo: json['SrNo'] as int,
      question: json['Question'] as String,
      isHtmlTag: json['isHtmlTag'] as String,
      quesType: json['quesType'] as String,
      answer: json['Answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SrNo': srNo,
      'Question': question,
      'isHtmlTag': isHtmlTag,
      'quesType': quesType,
      'Answer': answer,
    };
  }
}
