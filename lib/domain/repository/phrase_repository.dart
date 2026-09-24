import 'package:phroneo/domain/model/phrase.dart';

abstract class PhraseRepository {
  PhraseModel getRandomPhrase();
}