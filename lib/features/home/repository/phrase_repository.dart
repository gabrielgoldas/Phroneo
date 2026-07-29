import 'package:phroneo/features/home/model/phrase_model.dart';

class PhraseRepository {

  final List<PhraseModel> _allPhrases = [
    PhraseModel(
      text: 'O que você levaria para uma ilha deserta?',
      biggestNumber: '100 -> Não pode faltar',
      smallestNumber: '1 -> Desnecessário',
    ),
    PhraseModel(
      text: 'Quão perigoso seria ter esse animal de estimação?',
      biggestNumber: '100 -> Risco de morte',
      smallestNumber: '1 -> Totalmente inofensivo',
    ),
    PhraseModel(
      text: 'Qual a melhor invenção da humanidade?',
      biggestNumber: '100 -> Revolucionou o mundo',
      smallestNumber: '1 -> Inútil',
    ),
    PhraseModel(
      text: 'Quão ruim é essa tarefa doméstica?',
      biggestNumber: '100 -> Prefiro chorar no banho',
      smallestNumber: '1 -> Faço sorrindo',
    ),
    PhraseModel(
      text: 'Qual o melhor poder de super-herói?',
      biggestNumber: '100 -> Invencível',
      smallestNumber: '1 -> Totalmente inútil',
    ),
    // Adicione quantas quiser aqui...
  ];

  List<PhraseModel> _queue = [];

  PhraseModel getRandomPhrase() {
    if (_queue.isEmpty) {
      _queue = List<PhraseModel>.from(_allPhrases);
      _queue.shuffle();
    }

    return _queue.removeLast();
  }
}