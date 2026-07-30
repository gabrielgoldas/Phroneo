///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Phroneo'
	String get app_name => 'Phroneo';

	late final Translations$authPage$en authPage = Translations$authPage$en._(_root);
	late final Translations$gamePage$en gamePage = Translations$gamePage$en._(_root);
	late final Translations$homePage$en homePage = Translations$homePage$en._(_root);
	late final Translations$onboardingPage$en onboardingPage = Translations$onboardingPage$en._(_root);
	late final Translations$orderingPage$en orderingPage = Translations$orderingPage$en._(_root);
	late final Translations$roomLobby$en roomLobby = Translations$roomLobby$en._(_root);
}

// Path: authPage
class Translations$authPage$en {
	Translations$authPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign in with Google'
	String get login_google => 'Sign in with Google';

	/// en: 'Select your account here. By signing in, you agree to our privacy policy'
	String get privacy_policy => 'Select your account here. \nBy signing in, you agree to our privacy policy';

	/// en: 'Anonymous'
	String get anonymous => 'Anonymous';

	/// en: 'How to play'
	String get how_to_play => 'How to play';

	/// en: 'Log out'
	String get exit => 'Log out';
}

// Path: gamePage
class Translations$gamePage$en {
	Translations$gamePage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your number is:'
	String get yourNumberIs => 'Your number is:';

	/// en: 'Round phrase:'
	String get roundPhrase => 'Round phrase:';

	/// en: 'Tap and hold to see your number'
	String get tapAndHoldToSeeNumber => 'Tap and hold to see your number';

	/// en: 'Sort choices'
	String get sortChoices => 'Sort choices';
}

// Path: homePage
class Translations$homePage$en {
	Translations$homePage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create a match'
	String get create_match => 'Create a match';

	/// en: 'Join match'
	String get join_match => 'Join match';

	/// en: 'Create'
	String get confirm_creation => 'Create';

	/// en: 'How many players?'
	String get player_count_question => 'How many players?';

	/// en: 'Align the QR code in the center'
	String get alignQrCode => 'Align the QR code in the center';

	/// en: 'Let's play?'
	String get welcome_message => 'Let\'s play?';
}

// Path: onboardingPage
class Translations$onboardingPage$en {
	Translations$onboardingPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ready!'
	String get ready => 'Ready!';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Prev'
	String get previous => 'Prev';

	late final Translations$onboardingPage$repo$en repo = Translations$onboardingPage$repo$en._(_root);
}

// Path: orderingPage
class Translations$orderingPage$en {
	Translations$orderingPage$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sort the colors according to the imagined number. The numbers must be from highest to lowest.'
	String get sortChoicesInstruction => 'Sort the colors according to the imagined number. \nThe numbers must be from highest to lowest.';

	/// en: 'Highest number (100)'
	String get highestNumberLabel => 'Highest number (100)';

	/// en: 'Lowest number (1)'
	String get lowestNumberLabel => 'Lowest number (1)';

	/// en: 'Done'
	String get doneButton => 'Done';

	/// en: 'You Won!'
	String get victoryMessage => 'You Won!';

	/// en: 'You Lost!'
	String get defeatMessage => 'You Lost!';

	/// en: 'Congratulations'
	String get congratulationsTitle => 'Congratulations';

	/// en: 'Too bad'
	String get tooBadTitle => 'Too bad';

	/// en: 'Leave'
	String get leave => 'Leave';

	/// en: 'New Round'
	String get newRoundButton => 'New Round';
}

// Path: roomLobby
class Translations$roomLobby$en {
	Translations$roomLobby$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All the players joined the match'
	String get allPlayersJoinedMatch => 'All the players joined the match';

	/// en: '${current} de ${max} entraram'
	String playersJoined({required Object current, required Object max}) => '${current} de ${max} entraram';

	/// en: 'Wait'
	String get wait => 'Wait';

	/// en: 'The players are still joining the match...'
	String get playersStillJoining => 'The players are still joining the match...';

	/// en: 'Start'
	String get startButton => 'Start';

	/// en: 'Show the QR Code to your friends so they can play with you!'
	String get shareQrCodeInstruction => 'Show the QR Code to your friends so they can play with you!';
}

// Path: onboardingPage.repo
class Translations$onboardingPage$repo$en {
	Translations$onboardingPage$repo$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$onboardingPage$repo$objective$en objective = Translations$onboardingPage$repo$objective$en._(_root);
	late final Translations$onboardingPage$repo$receiveNumber$en receiveNumber = Translations$onboardingPage$repo$receiveNumber$en._(_root);
	late final Translations$onboardingPage$repo$thinkPhrase$en thinkPhrase = Translations$onboardingPage$repo$thinkPhrase$en._(_root);
	late final Translations$onboardingPage$repo$discoverOrder$en discoverOrder = Translations$onboardingPage$repo$discoverOrder$en._(_root);
	late final Translations$onboardingPage$repo$reveal$en reveal = Translations$onboardingPage$repo$reveal$en._(_root);
}

// Path: onboardingPage.repo.objective
class Translations$onboardingPage$repo$objective$en {
	Translations$onboardingPage$repo$objective$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The objective'
	String get title => 'The objective';

	/// en: 'Work together to put the numbers in the correct order.'
	String get description => 'Work together to put the numbers in the correct order.';
}

// Path: onboardingPage.repo.receiveNumber
class Translations$onboardingPage$repo$receiveNumber$en {
	Translations$onboardingPage$repo$receiveNumber$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Receive your number'
	String get title => 'Receive your number';

	/// en: 'When starting a round, each player receives a secret number and a color. The higher the number, the more your answer should represent the upper end of the scale. The lower the number, the closer it should be to the lower end.'
	String get description => 'When starting a round, each player receives a secret number and a color.\n\nThe higher the number, the more your answer should represent the upper end of the scale. The lower the number, the closer it should be to the lower end.';
}

// Path: onboardingPage.repo.thinkPhrase
class Translations$onboardingPage$repo$thinkPhrase$en {
	Translations$onboardingPage$repo$thinkPhrase$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Think about the phrase'
	String get title => 'Think about the phrase';

	/// en: 'A phrase will be presented to all players. Example: "How tasty is this food?" 1 → something you would never eat 100 → your favorite food IMPORTANT Do not reveal your answer'
	String get description => 'A phrase will be presented to all players.\n\nExample: "How tasty is this food?"\n\n1 → something you would never eat\n100 → your favorite food\n\nIMPORTANT\nDo not reveal your answer';
}

// Path: onboardingPage.repo.discoverOrder
class Translations$onboardingPage$repo$discoverOrder$en {
	Translations$onboardingPage$repo$discoverOrder$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Discover the order'
	String get title => 'Discover the order';

	/// en: 'After everyone answers: Listen to each other's answers Discuss as a group Try to discover the correct position of each player The goal is to build the number sequence without anyone revealing their value.'
	String get description => 'After everyone answers:\n\nListen to each other\'s answers\nDiscuss as a group\nTry to discover the correct position of each player\n\nThe goal is to build the number sequence without anyone revealing their value.';
}

// Path: onboardingPage.repo.reveal
class Translations$onboardingPage$repo$reveal$en {
	Translations$onboardingPage$repo$reveal$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reveal'
	String get title => 'Reveal';

	/// en: 'When the group is ready: Confirm the chosen sequence Reveal the numbers Find out if the order is correct If all players are in the correct position, the round is won!'
	String get description => 'When the group is ready:\n\nConfirm the chosen sequence\nReveal the numbers\nFind out if the order is correct\n\n   If all players are in the correct position, the round is won!';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Phroneo',
			'authPage.login_google' => 'Sign in with Google',
			'authPage.privacy_policy' => 'Select your account here. \nBy signing in, you agree to our privacy policy',
			'authPage.anonymous' => 'Anonymous',
			'authPage.how_to_play' => 'How to play',
			'authPage.exit' => 'Log out',
			'gamePage.yourNumberIs' => 'Your number is:',
			'gamePage.roundPhrase' => 'Round phrase:',
			'gamePage.tapAndHoldToSeeNumber' => 'Tap and hold to see your number',
			'gamePage.sortChoices' => 'Sort choices',
			'homePage.create_match' => 'Create a match',
			'homePage.join_match' => 'Join match',
			'homePage.confirm_creation' => 'Create',
			'homePage.player_count_question' => 'How many players?',
			'homePage.alignQrCode' => 'Align the QR code in the center',
			'homePage.welcome_message' => 'Let\'s play?',
			'onboardingPage.ready' => 'Ready!',
			'onboardingPage.next' => 'Next',
			'onboardingPage.previous' => 'Prev',
			'onboardingPage.repo.objective.title' => 'The objective',
			'onboardingPage.repo.objective.description' => 'Work together to put the numbers in the correct order.',
			'onboardingPage.repo.receiveNumber.title' => 'Receive your number',
			'onboardingPage.repo.receiveNumber.description' => 'When starting a round, each player receives a secret number and a color.\n\nThe higher the number, the more your answer should represent the upper end of the scale. The lower the number, the closer it should be to the lower end.',
			'onboardingPage.repo.thinkPhrase.title' => 'Think about the phrase',
			'onboardingPage.repo.thinkPhrase.description' => 'A phrase will be presented to all players.\n\nExample: "How tasty is this food?"\n\n1 → something you would never eat\n100 → your favorite food\n\nIMPORTANT\nDo not reveal your answer',
			'onboardingPage.repo.discoverOrder.title' => 'Discover the order',
			'onboardingPage.repo.discoverOrder.description' => 'After everyone answers:\n\nListen to each other\'s answers\nDiscuss as a group\nTry to discover the correct position of each player\n\nThe goal is to build the number sequence without anyone revealing their value.',
			'onboardingPage.repo.reveal.title' => 'Reveal',
			'onboardingPage.repo.reveal.description' => 'When the group is ready:\n\nConfirm the chosen sequence\nReveal the numbers\nFind out if the order is correct\n\n   If all players are in the correct position, the round is won!',
			'orderingPage.sortChoicesInstruction' => 'Sort the colors according to the imagined number. \nThe numbers must be from highest to lowest.',
			'orderingPage.highestNumberLabel' => 'Highest number (100)',
			'orderingPage.lowestNumberLabel' => 'Lowest number (1)',
			'orderingPage.doneButton' => 'Done',
			'orderingPage.victoryMessage' => 'You Won!',
			'orderingPage.defeatMessage' => 'You Lost!',
			'orderingPage.congratulationsTitle' => 'Congratulations',
			'orderingPage.tooBadTitle' => 'Too bad',
			'orderingPage.leave' => 'Leave',
			'orderingPage.newRoundButton' => 'New Round',
			'roomLobby.allPlayersJoinedMatch' => 'All the players joined the match',
			'roomLobby.playersJoined' => ({required Object current, required Object max}) => '${current} de ${max} entraram',
			'roomLobby.wait' => 'Wait',
			'roomLobby.playersStillJoining' => 'The players are still joining the match...',
			'roomLobby.startButton' => 'Start',
			'roomLobby.shareQrCodeInstruction' => 'Show the QR Code to your friends so they can play with you!',
			_ => null,
		};
	}
}
