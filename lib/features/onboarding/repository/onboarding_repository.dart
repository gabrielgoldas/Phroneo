import 'package:phroneo/features/onboarding/model/onboarding_page_model.dart';

class OnboardingRepository {

  final List<OnboardingModel> _allOnboardingData = [
    OnboardingModel(title: "O objetivo",         description: "Trabalhem juntos para colocar os números na ordem correta."),
    OnboardingModel(title: "Receba seu número",  description: "Ao iniciar uma rodada, cada jogador recebe um número secreto e uma cor. \n\nQuanto maior o número, mais sua resposta deve representar o extremo superior da escala. Quanto menor o número, mais próximo do extremo inferior."),
    OnboardingModel(title: "Pense na frase",     description: "Uma frase será apresentada para todos os jogadores. \n\nExemplo: \"Quão gostosa é essa comida?\" \n\n1 → algo que você jamais comeria \n100 → sua comida favorita \n\nIMPORTANTE \nNão fale sua resposta"),
    OnboardingModel(title: "Descubram a ordem",  description: "Após todos responderem:\n\nEscutem as respostas uns dos outros\nDiscutam em grupo\nTentem descobrir a posição correta de cada jogador \n\nO objetivo é montar a sequência dos números sem que ninguém revele seu valor."),
    OnboardingModel(title: "Revelação",          description: "Quando o grupo estiver pronto: \n\nConfirmem a sequência escolhida \nRevelem os números \nDescubram se a ordem está correta \n\n   Se todos os jogadores estiverem na posição certa, a rodada é vencida!"),
  ];

  List<OnboardingModel> get allOnboardingData => _allOnboardingData;
}