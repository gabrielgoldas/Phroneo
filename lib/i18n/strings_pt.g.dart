///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsPt with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => 'Phroneo';
	@override late final _Translations$authPage$pt authPage = _Translations$authPage$pt._(_root);
	@override late final _Translations$gamePage$pt gamePage = _Translations$gamePage$pt._(_root);
	@override late final _Translations$homePage$pt homePage = _Translations$homePage$pt._(_root);
	@override late final _Translations$onboardingPage$pt onboardingPage = _Translations$onboardingPage$pt._(_root);
	@override late final _Translations$orderingPage$pt orderingPage = _Translations$orderingPage$pt._(_root);
	@override late final _Translations$roomLobby$pt roomLobby = _Translations$roomLobby$pt._(_root);
}

// Path: authPage
class _Translations$authPage$pt implements Translations$authPage$en {
	_Translations$authPage$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get login_google => 'Entrar com o Google';
	@override String get privacy_policy => 'Selecione sua conta aqui. \nAo entrar, você concorda com nossa política de privacidade';
	@override String get anonymous => 'Anônimo';
	@override String get how_to_play => 'Como jogar';
	@override String get exit => 'Sair';
}

// Path: gamePage
class _Translations$gamePage$pt implements Translations$gamePage$en {
	_Translations$gamePage$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get yourNumberIs => 'Seu número é:';
	@override String get roundPhrase => 'Frase da rodada:';
	@override String get tapAndHoldToSeeNumber => 'Toque e segure para ver seu número';
	@override String get sortChoices => 'Ordenar Escolhas';
}

// Path: homePage
class _Translations$homePage$pt implements Translations$homePage$en {
	_Translations$homePage$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get create_match => 'Criar uma partida';
	@override String get join_match => 'Entrar na partida';
	@override String get confirm_creation => 'Criar';
	@override String get player_count_question => 'Quantas pessoas vão jogar?';
	@override String get alignQrCode => 'Alinhe o QR Code no centro';
	@override String get welcome_message => 'Vamos jogar?';
}

// Path: onboardingPage
class _Translations$onboardingPage$pt implements Translations$onboardingPage$en {
	_Translations$onboardingPage$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get ready => 'Pronto!';
	@override String get next => 'Próximo';
	@override String get previous => 'Anterior';
	@override late final _Translations$onboardingPage$repo$pt repo = _Translations$onboardingPage$repo$pt._(_root);
}

// Path: orderingPage
class _Translations$orderingPage$pt implements Translations$orderingPage$en {
	_Translations$orderingPage$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get sortChoicesInstruction => 'Ordene as cores conforme o número imaginado. \nOs Números devem estar do maior para o menor.';
	@override String get highestNumberLabel => 'Maior número (100)';
	@override String get lowestNumberLabel => 'Menor número (1)';
	@override String get doneButton => 'Concluído';
	@override String get victoryMessage => 'Vocês Venceram!';
	@override String get defeatMessage => 'Vocês Perderam!';
	@override String get congratulationsTitle => 'Parabéns';
	@override String get tooBadTitle => 'Que pena';
	@override String get leave => 'Sair';
	@override String get newRoundButton => 'Nova Rodada';
}

// Path: roomLobby
class _Translations$roomLobby$pt implements Translations$roomLobby$en {
	_Translations$roomLobby$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get allPlayersJoinedMatch => 'Todos os jogadores entraram na partida';
	@override String playersJoined({required Object current, required Object max}) => '${current} de ${max} entraram';
	@override String get wait => 'Aguarde';
	@override String get playersStillJoining => 'Os jogadores ainda estão entrando na partida...';
	@override String get startButton => 'Iniciar';
	@override String get shareQrCodeInstruction => 'Mostre o QR Code para seus amigos jogarem com você!';
}

// Path: onboardingPage.repo
class _Translations$onboardingPage$repo$pt implements Translations$onboardingPage$repo$en {
	_Translations$onboardingPage$repo$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$onboardingPage$repo$objective$pt objective = _Translations$onboardingPage$repo$objective$pt._(_root);
	@override late final _Translations$onboardingPage$repo$receiveNumber$pt receiveNumber = _Translations$onboardingPage$repo$receiveNumber$pt._(_root);
	@override late final _Translations$onboardingPage$repo$thinkPhrase$pt thinkPhrase = _Translations$onboardingPage$repo$thinkPhrase$pt._(_root);
	@override late final _Translations$onboardingPage$repo$discoverOrder$pt discoverOrder = _Translations$onboardingPage$repo$discoverOrder$pt._(_root);
	@override late final _Translations$onboardingPage$repo$reveal$pt reveal = _Translations$onboardingPage$repo$reveal$pt._(_root);
}

// Path: onboardingPage.repo.objective
class _Translations$onboardingPage$repo$objective$pt implements Translations$onboardingPage$repo$objective$en {
	_Translations$onboardingPage$repo$objective$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'O objetivo';
	@override String get description => 'Trabalhem juntos para colocar os números na ordem correta.';
}

// Path: onboardingPage.repo.receiveNumber
class _Translations$onboardingPage$repo$receiveNumber$pt implements Translations$onboardingPage$repo$receiveNumber$en {
	_Translations$onboardingPage$repo$receiveNumber$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Receba seu número';
	@override String get description => 'Ao iniciar uma rodada, cada jogador recebe um número secreto e uma cor.\n\nQuanto maior o número, mais sua resposta deve representar o extremo superior da escala. Quanto menor o número, mais próximo do extremo inferior.';
}

// Path: onboardingPage.repo.thinkPhrase
class _Translations$onboardingPage$repo$thinkPhrase$pt implements Translations$onboardingPage$repo$thinkPhrase$en {
	_Translations$onboardingPage$repo$thinkPhrase$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pense na frase';
	@override String get description => 'Uma frase será apresentada para todos os jogadores.\n\nExemplo: "Quão gostosa é essa comida?"\n\n1 → algo que você jamais comeria\n100 → sua comida favorita\n\nIMPORTANTE\nNão fale sua resposta';
}

// Path: onboardingPage.repo.discoverOrder
class _Translations$onboardingPage$repo$discoverOrder$pt implements Translations$onboardingPage$repo$discoverOrder$en {
	_Translations$onboardingPage$repo$discoverOrder$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descubram a ordem';
	@override String get description => 'Após todos responderem:\n\nEscutem as respostas uns dos outros\nDiscutam em grupo\nTentem descobrir a posição correta de cada jogador\n\nO objetivo é montar a sequência dos números sem que ninguém revele seu valor.';
}

// Path: onboardingPage.repo.reveal
class _Translations$onboardingPage$repo$reveal$pt implements Translations$onboardingPage$repo$reveal$en {
	_Translations$onboardingPage$repo$reveal$pt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Revelação';
	@override String get description => 'Quando o grupo estiver pronto:\n\nConfirmem a sequência escolhida\nRevelem os números\nDescubram se a ordem está correta\n\n   Se todos os jogadores estiverem na posição certa, a rodada é vencida!';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Phroneo',
			'authPage.login_google' => 'Entrar com o Google',
			'authPage.privacy_policy' => 'Selecione sua conta aqui. \nAo entrar, você concorda com nossa política de privacidade',
			'authPage.anonymous' => 'Anônimo',
			'authPage.how_to_play' => 'Como jogar',
			'authPage.exit' => 'Sair',
			'gamePage.yourNumberIs' => 'Seu número é:',
			'gamePage.roundPhrase' => 'Frase da rodada:',
			'gamePage.tapAndHoldToSeeNumber' => 'Toque e segure para ver seu número',
			'gamePage.sortChoices' => 'Ordenar Escolhas',
			'homePage.create_match' => 'Criar uma partida',
			'homePage.join_match' => 'Entrar na partida',
			'homePage.confirm_creation' => 'Criar',
			'homePage.player_count_question' => 'Quantas pessoas vão jogar?',
			'homePage.alignQrCode' => 'Alinhe o QR Code no centro',
			'homePage.welcome_message' => 'Vamos jogar?',
			'onboardingPage.ready' => 'Pronto!',
			'onboardingPage.next' => 'Próximo',
			'onboardingPage.previous' => 'Anterior',
			'onboardingPage.repo.objective.title' => 'O objetivo',
			'onboardingPage.repo.objective.description' => 'Trabalhem juntos para colocar os números na ordem correta.',
			'onboardingPage.repo.receiveNumber.title' => 'Receba seu número',
			'onboardingPage.repo.receiveNumber.description' => 'Ao iniciar uma rodada, cada jogador recebe um número secreto e uma cor.\n\nQuanto maior o número, mais sua resposta deve representar o extremo superior da escala. Quanto menor o número, mais próximo do extremo inferior.',
			'onboardingPage.repo.thinkPhrase.title' => 'Pense na frase',
			'onboardingPage.repo.thinkPhrase.description' => 'Uma frase será apresentada para todos os jogadores.\n\nExemplo: "Quão gostosa é essa comida?"\n\n1 → algo que você jamais comeria\n100 → sua comida favorita\n\nIMPORTANTE\nNão fale sua resposta',
			'onboardingPage.repo.discoverOrder.title' => 'Descubram a ordem',
			'onboardingPage.repo.discoverOrder.description' => 'Após todos responderem:\n\nEscutem as respostas uns dos outros\nDiscutam em grupo\nTentem descobrir a posição correta de cada jogador\n\nO objetivo é montar a sequência dos números sem que ninguém revele seu valor.',
			'onboardingPage.repo.reveal.title' => 'Revelação',
			'onboardingPage.repo.reveal.description' => 'Quando o grupo estiver pronto:\n\nConfirmem a sequência escolhida\nRevelem os números\nDescubram se a ordem está correta\n\n   Se todos os jogadores estiverem na posição certa, a rodada é vencida!',
			'orderingPage.sortChoicesInstruction' => 'Ordene as cores conforme o número imaginado. \nOs Números devem estar do maior para o menor.',
			'orderingPage.highestNumberLabel' => 'Maior número (100)',
			'orderingPage.lowestNumberLabel' => 'Menor número (1)',
			'orderingPage.doneButton' => 'Concluído',
			'orderingPage.victoryMessage' => 'Vocês Venceram!',
			'orderingPage.defeatMessage' => 'Vocês Perderam!',
			'orderingPage.congratulationsTitle' => 'Parabéns',
			'orderingPage.tooBadTitle' => 'Que pena',
			'orderingPage.leave' => 'Sair',
			'orderingPage.newRoundButton' => 'Nova Rodada',
			'roomLobby.allPlayersJoinedMatch' => 'Todos os jogadores entraram na partida',
			'roomLobby.playersJoined' => ({required Object current, required Object max}) => '${current} de ${max} entraram',
			'roomLobby.wait' => 'Aguarde',
			'roomLobby.playersStillJoining' => 'Os jogadores ainda estão entrando na partida...',
			'roomLobby.startButton' => 'Iniciar',
			'roomLobby.shareQrCodeInstruction' => 'Mostre o QR Code para seus amigos jogarem com você!',
			_ => null,
		};
	}
}
