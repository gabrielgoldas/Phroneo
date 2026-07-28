class PhraseModel {
  final String text;
  final String biggestNumber;
  final String smallestNumber;

  PhraseModel({
    required this.text,
    required this.biggestNumber,
    required this.smallestNumber
  });

  factory PhraseModel.fromMap(Map<String, dynamic> map) {
    return PhraseModel(
        text: map['text'] ?? '',
        biggestNumber: map['biggestNumber'] ?? '',
        smallestNumber: map['smallestNumber'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'biggestNumber': biggestNumber,
      'smallestNumber': smallestNumber
    };
  }
}