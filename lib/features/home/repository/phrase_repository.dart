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
    PhraseModel(
      text: 'Qual filme você recomendaria para alguém que nunca assistiu cinema?',
      biggestNumber: '100 -> Um clássico obriatório',
      smallestNumber: '1 -> Um filme ruim/esquecível',
    ),
    PhraseModel(
      text: 'Qual superpoder você gostaria de ter?',
      biggestNumber: '100 -> Absurdamente poderoso',
      smallestNumber: '1 -> Totalmente inútil',
    ),
    PhraseModel(
      text: 'Qual seria o melhor nome para seu pet?',
      biggestNumber: '100 -> Melhor nome já inventado',
      smallestNumber: '1 -> Esse eu nunca colocaria',
    ),
    PhraseModel(
      text: 'Qual animal você escolheria para criar dentro de casa?',
      biggestNumber: '100 -> O companheiro perfeito',
      smallestNumber: '1 -> De jeito nenhum',
    ),
    PhraseModel(
      text: 'Qual comida você escolheria para comer o resto da sua vida?',
      biggestNumber: '100 -> Sua comida favorita',
      smallestNumber: '1 -> Prefiro passar fome',
    ),
    PhraseModel(
      text: 'Se você só pudesse escutar uma música por toda a vida, qual seria?',
      biggestNumber: '100 -> Sua música favorita',
      smallestNumber: '1 -> Odeio essa música',
    ),
    PhraseModel(
      text: 'Se você pudesse criar um perfume novo usando usando cheiro de comida, qual seria?',
      biggestNumber: '100 -> Melhor cheiro de comida',
      smallestNumber: '1 -> Passo mal só de pensar',
    ),
    PhraseModel(
      text: 'Qual seria o poder mais inútil para se ter?',
      biggestNumber: '100 -> Extremamente inútil',
      smallestNumber: '1 -> Muito útil',
    ),
    PhraseModel(
      text: 'O quão constrangedora seria essa situação?',
      biggestNumber: '100 -> Morro de vergonha',
      smallestNumber: '1 -> Nem me abalo',
    ),
    PhraseModel(
      text: 'Se eu tivesse que estolher um famoso para me casar, qual seria?',
      biggestNumber: '100 -> Me derreto todo',
      smallestNumber: '1 -> Prefiro morrer sozinho',
    ),
    PhraseModel(
      text: 'Se eu pudesser ser um famoso, quem eu seria?',
      biggestNumber: '100 -> Sou muito fã',
      smallestNumber: '1 -> Nem gosto dele(a)',
    ),
    PhraseModel(
      text: 'Algo que você jamais gostaria de ouvir no meio de uma cirurgia',
      biggestNumber: '100 -> Não gostaria de ouvir',
      smallestNumber: '1 -> Não faz diferença',
    ),
    PhraseModel(
      text: 'Qual o seu maior medo?',
      biggestNumber: '100 -> Morro de medo',
      smallestNumber: '1 -> Nem me abalo',
    ),
    PhraseModel(
      text: 'O que te deixaria mais feliz?',
      biggestNumber: '100 -> Sorrindo de orelha a orelha',
      smallestNumber: '1 -> Não mudaria meu dia',
    ),
    PhraseModel(
      text: 'Qual seria a pior música para se tocar em um casamento?',
      biggestNumber: '100 -> Melhor música',
      smallestNumber: '1 -> Pior música possível',
    ),
    PhraseModel(
      text: 'Qual seria a pior música para se tocar em um enterro?',
      biggestNumber: '100 -> Melhor música',
      smallestNumber: '1 -> Pior música possível',
    ),
    PhraseModel(
      text: 'Qual seria o pior lugar para esquecer o celular?',
      biggestNumber: '100 -> Um desastre',
      smallestNumber: '1 -> Busco depois',
    ),
    PhraseModel(
      text: 'Sua casa está pegando fogo e você só pode pegar uma coisa da casa, o que você pegaria?',
      biggestNumber: '100 -> Não posso perder',
      smallestNumber: '1 -> Pode ficar',
    ),
    PhraseModel(
      text: 'Qual seria o melhor lugar para morar?',
      biggestNumber: '100 -> Moraria feliz',
      smallestNumber: '1 -> Nunca pisaria lá',
    ),
    PhraseModel(
      text: 'Se você pudesse ter somente um aplicatio no seu celular, qual seria?',
      biggestNumber: '100 -> Não vivo sem',
      smallestNumber: '1 -> Nem instalaria',
    ),
    PhraseModel(
      text: 'Qual seria o melhor lugar para um primeiro encontro?',
      biggestNumber: '100 -> Perfeito',
      smallestNumber: '1 -> Péssima ideia',
    ),
    PhraseModel(
      text: 'Qual seria a melhor sobremesa do mundo?',
      biggestNumber: '100 -> Quero agora',
      smallestNumber: '1 -> Nem experimentaria',
    ),
    PhraseModel(
      text: 'Qual a chance disso acontecer com você ainda este ano?',
      biggestNumber: '100 -> É praticamente certo',
      smallestNumber: '1 -> Nunca acontecerá',
    ),
    PhraseModel(
      text: 'O que você pediria como última refeição?',
      biggestNumber: '100 -> Não poderia morrer sem',
      smallestNumber: '1 -> Morro em jejum',
    ),
    PhraseModel(
      text: 'O que você pediria como última refeição?',
      biggestNumber: '100 -> Não poderia morrer sem',
      smallestNumber: '1 -> Morro em jejum',
    ),
    PhraseModel(
      text: 'Qual objeto teria mais valor sentimental para você?',
      biggestNumber: '100 -> Jamais de desfaria',
      smallestNumber: '1 -> Não significa nada',
    ),
    PhraseModel(
      text: 'Se você pudesse reviver uma memória de infância, qual seria',
      biggestNumber: '100 -> Reviveria mil vezes',
      smallestNumber: '1 -> Prefiro esquecer',
    ),
    PhraseModel(
      text: 'Qual acontecimento faria você pensar: "Hoje é meu dia de sorte"?',
      biggestNumber: '100 -> Sorte inacreditável',
      smallestNumber: '1 -> Nada demais',
    ),
    PhraseModel(
      text: 'Em qual fila você menos gostaria de esperar?',
      biggestNumber: '100 -> Desisto na hora',
      smallestNumber: '1 -> Esperaria dias',
    ),
    PhraseModel(
      text: 'Qual situação mais testa sua paciência?',
      biggestNumber: '100 -> Perco a cabeça',
      smallestNumber: '1 -> Nem ligo',
    ),
    PhraseModel(
      text: 'Qual talento impressiona mais?',
      biggestNumber: '100 -> Incrível',
      smallestNumber: '1 -> Nada demais',
    ),
    PhraseModel(
      text: 'O que mais te faz lembrar a sua infância?',
      biggestNumber: '100 -> Nostalgia pura',
      smallestNumber: '1 -> Não me lembra de nada',
    ),
    PhraseModel(
      text: 'Para qual compromisso seria pior chegar atrasado?',
      biggestNumber: '100 -> Imperdoável',
      smallestNumber: '1 -> Ninguém liga',
    ),
    PhraseModel(
      text: 'Qual seria o item mais inútil para levar num apocalipse?',
      biggestNumber: '100 -> Completamente inútil',
      smallestNumber: '1 -> Surpreendentemente útil',
    ),
    PhraseModel(
      text: 'Qual seria o pior lugar para ficar preso por uma hora?',
      biggestNumber: '100 -> Pânico total',
      smallestNumber: '1 -> Até relaxaria',
    ),
    PhraseModel(
      text: 'Qual comida seria mais perigosa para comer antes de um encontro?',
      biggestNumber: '100 -> Risco de constrangimento',
      smallestNumber: '1 -> Escolha segura',
    ),
    PhraseModel(
      text: 'Você tem que cancelar um compromisso, qual seria a melhor desculpa?',
      biggestNumber: '100 -> Ninguém questionaria',
      smallestNumber: '1 -> Muito suspeita',
    ),
    PhraseModel(
      text: 'Qual seria o objeto mais constrangedor de encontrar na sua mochila?',
      biggestNumber: '100 -> Vergonha máxima',
      smallestNumber: '1 -> Normal demais',
    ),
    PhraseModel(
      text: 'Você vai pedir seu par em casamento, qual o lugar mais romântico para fazer o pedido?',
      biggestNumber: '100 -> Cena de filme',
      smallestNumber: '1 -> Melhor nem pedir',
    ),
    PhraseModel(
      text: 'Qual seria a pior coisa para descobrir no dia do seu aniversário?',
      biggestNumber: '100 -> Aniversário arruinado',
      smallestNumber: '1 -> Tudo bem',
    ),
    PhraseModel(
      text: 'Qual seria o pior cheiro para sentir num elevador lotado?',
      biggestNumber: '100 -> Insuportável',
      smallestNumber: '1 -> Imperceptível',
    ),
    PhraseModel(
      text: 'Qual seria o melhor presente de amigo secreto?',
      biggestNumber: '100 -> Eu adoraria',
      smallestNumber: '1 -> Decepção total',
    ),
    PhraseModel(
      text: 'Qual seria o lugar mais estranho para encontrar seu ex?',
      biggestNumber: '100 -> Constrangimento total',
      smallestNumber: '1 -> De boa',
    ),
    PhraseModel(
      text: 'Qual alimento seria mais reconfortante para um dia frio?',
      biggestNumber: '100 -> Abraço em forma de comida',
      smallestNumber: '1 -> Não aquece a alma',
    ),
    PhraseModel(
      text: 'Qual situação seria mais difícil de explicar para seus pais?',
      biggestNumber: '100 -> Impossível explicar',
      smallestNumber: '1 -> Numa boa',
    ),
    PhraseModel(
      text: 'Numa brincadeira de esconde-esconde, qual seria o melhor esconderijo?',
      biggestNumber: '100 -> Ninguém acharia',
      smallestNumber: '1 -> Achei na hora',
    ),
    PhraseModel(
      text: 'Algo que todo mundo tem em casa, mas raramente usa.',
      biggestNumber: '100 -> Totalmente esquecido/empoeirado',
      smallestNumber: '1 -> Uso quase diário',
    ),
    PhraseModel(
      text: 'Sabor de pizza que divide opiniões.',
      biggestNumber: '100 -> Obra-prima incompreendida',
      smallestNumber: '1 -> Abominação culinária',
    ),
    PhraseModel(
      text: 'Sabor de sorvete que deveria ser proibido por lei.',
      biggestNumber: '100 -> Crime contra a culinária',
      smallestNumber: '1 -> Até que é aceitável',
    ),
    PhraseModel(
      text: 'O que não pode faltar na mesa de um churrasco de domingo.',
      biggestNumber: '100 -> Sem isso nem acendo a brasa',
      smallestNumber: '1 -> Nem reparo se falta',
    ),
    PhraseModel(
      text: 'Combinação de comida que parece ruim, mas é boa.',
      biggestNumber: '100 -> Descoberta genial',
      smallestNumber: '1 -> Ainda acho ruim',
    ),
    PhraseModel(
      text: 'O que você faria se visse um OVNI no seu quintal.',
      biggestNumber: '100 -> Atitude extrema e corajosa',
      smallestNumber: '1 -> Fugiria chorando',
    ),
    PhraseModel(
      text: 'Habilidade inútil que você tem (ou gostaria de ter).',
      biggestNumber: '100 -> Festa de família garantida',
      smallestNumber: '1 -> Nem serve para impressionar',
    ),
    PhraseModel(
      text: 'Personagem de filme que seria o pior colega de quarto.',
      biggestNumber: '100 -> Insuportável',
      smallestNumber: '1 -> Ótima convivência',
    ),
    PhraseModel(
      text: 'Alguém que você levaria para jantar com sua família.',
      biggestNumber: '100 -> Orgulho da família',
      smallestNumber: '1 -> Vergonha alheia total',
    ),
    PhraseModel(
      text: 'Personagem histórico que você chamaria para tomar uma café.',
      biggestNumber: '100 -> A conversa do século',
      smallestNumber: '1 -> Papo muito chato',
    ),
    PhraseModel(
      text: 'Situação que te faria pedir demissão na hora.',
      biggestNumber: '100 -> Não aceito',
      smallestNumber: '1 -> Reclamo, mas continuo',
    ),
    PhraseModel(
      text: 'Pior momento possível para o seu celular descarregar.',
      biggestNumber: '100 -> Catástrofe absoluta',
      smallestNumber: '1 -> Só um leve inconveniente',
    ),
    PhraseModel(
      text: 'Lugar perfeito para tirar uma soneca.',
      biggestNumber: '100 -> Sono dos anjos',
      smallestNumber: '1 -> Desconforto total',
    ),
    PhraseModel(
      text: 'Lugar onde você nunca gostaria de estar sozinho à noite.',
      biggestNumber: '100 -> Terror puro',
      smallestNumber: '1 -> De boa/Tranquilo',
    ),
    PhraseModel(
      text: 'Lugar perfeito para se esconder do seu chefe no trabalho.',
      biggestNumber: '100 -> Camuflagem perfeita',
      smallestNumber: '1 -> Me acha em 2 segundos',
    ),
    PhraseModel(
      text: 'Lugar mais provável para você perder as chaves de casa.',
      biggestNumber: '100 -> Outro planeta/Impossível de achar',
      smallestNumber: '1 -> No bolso da calça',
    ),


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