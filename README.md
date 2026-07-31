# Phroneo

Este aplicativo foi desenvolvido para ser um jogo multiplayer envolvente e interativo, onde sua jogabilidade é totalmente baseada em um jogo de cartas.

Neste projeto, coloquei em prática meus conhecimentos de desenvolvimento multiplataforma utilizando **Flutter** e **Dart**, aplicando conceitos como UI Reativa, Injeção de Dependência, Gerenciamento de Estado com Controllers (ChangeNotifier), Firebase Firestore para sincronização multiplayer em tempo real e navegação robusta com GoRouter.

## Screenshots

<p align="center">
  <img src="screenshots/img1.jpeg" width="150"/>
  <img src="screenshots/img2.jpeg" width="150"/>
  <img src="screenshots/img3.jpeg" width="150"/>
  <img src="screenshots/img4.png"  width="150"/>
  <img src="screenshots/img5.png"  width="150"/>
</p>

---

## Visão Geral

O aplicativo permite aos usuários:

- Criar salas de jogo exclusivas e atuar como host (responsável por gerenciar a partida) ou como um jogador comum.
- Entrar facilmente em partidas existentes por meio da leitura de QR Codes.
- Interagir em tempo real durante as rodadas do jogo (adivinhando números secretos, frases, etc.).
- Visualizar atualizações de estado imediatas, sincronizadas entre os dispositivos de todos os jogadores.

O projeto foi desenvolvido para demonstrar uma arquitetura moderna em Flutter, separação de responsabilidades e melhores práticas de escalabilidade e manutenibilidade.

---

## Autenticação e Banco de Dados

Este projeto utiliza o **Firebase Authentication** para oferecer acesso fácil e seguro aos usuários.
Para a mecânica principal do jogo, ele utiliza o **Firebase Firestore** para garantir a sincronização em tempo real e com baixa latência do estado da partida entre o anfitrião e os jogadores.

---

## Stack Tecnológica

Main technologies and architectural concepts used in this project:

Principais tecnologias e conceitos de arquitetura utilizados neste projeto:

- **Dart e Flutter**: Framework principal.
- **Gerenciamento de Estado**: `ChangeNotifier` / `ListenableBuilder` (estado reativo nativo).
- **Navegação**: `go_router` para *deep linking* e roteamento declarativo.
- **Injeção de Dependência**: `get_it` para desacoplamento de serviços e controladores.
- **Backend e Banco de Dados em Tempo Real**: Firebase (Auth e Firestore).
- **Relatório de Falhas**: Firebase Crashlytics.

Principais pacotes do Flutter utilizados:

- `qr_flutter` (Para geração de QR Codes das salas)
- `mobile_scanner` (Para leitura de QR Codes para entrar nas salas)

---

# Arquitetura e Estrutura do Projeto (Phroneo)

O projeto é organizado por features (Feature-First Architecture) para manter o desacoplamento.

Este documento descreve a organização de diretórios, padrões de projeto e o fluxo de dados adotados no aplicativo. O projeto segue uma abordagem **Feature-First** combinada com **Injeção de Dependência** e gerenciamento de estado reativo.

### Estrutura de Diretórios

O projeto é dividido em duas grandes frentes: `core` (recursos globais e compartilhados) e `features` (módulos isolados por funcionalidade).

```text
lib/
├── core/                       # Núcleo e configurações globais do app
│   ├── constants/              # Constantes globais (ex: status de partidas, regras)
│   ├── di/                     # Injeção de dependência (GetIt / injection.dart)
│   ├── router/                 # Configuração de rotas (GoRouter e app_routes.dart)
│   ├── theme/                  # Design System (Cores, fontes, tamanhos)
│   ├── utils/                  # Utilitários, extensões e helpers (ex: localization)
│   └── widgets/                # Widgets globais reaproveitáveis (ex: botões, app bars)
│
├── features/                   # Módulos de negócio divididos por funcionalidade
│   ├── auth/                   # Módulo de Autenticação
│   │   ├── data/               # Repositórios e fontes de dados
│   │   ├── services/           # Contêm lógica de negócio, interagem com Firebase ou repository
│   │   └── presentation/       # Camada visual e de apresentação
│   │       ├── controllers/    # AuthController (Gerenciamento de estado)
│   │       └── pages/          # Telas (LoginPage, etc.)
│   │
│   ├── home/                   # Módulo da Tela Principal / Home
│   ├── game/                   # Módulo da Partida / Jogo
│   ├── room_lobby/             # Módulo do Lobby da Sala / QR Code
│   ├── ordering/               # Módulo de Ordenação e Resultados
│   └── ...
│
└── main.dart                   # Ponto de entrada da aplicação
```

### Fluxo de dados

```text
Presentation → Controller (Gerencia estado / Dispara lógica) → Service (Aplica regras de negócio) → Repository / Firebase (Persistência e fontes externas)
```
