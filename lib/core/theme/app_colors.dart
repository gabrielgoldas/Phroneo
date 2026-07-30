import 'dart:ui';

class AppColors {
  // --- UI / Theme Colors ---
  static const background             = Color(0xFFD8C3B5);
  static const backgroundTransparent  = Color(0xC3D8C3B5);
  static const backgroundClearer      = Color(0xFFE3DAD1);
  static const bgTransparent          = Color(0xBD2D2D2D);
  static const primaryColor           = Color(0xFF774D4D);
  static const secondaryColor         = Color(0xFF8E6666);
  static const black                  = Color(0xFF2D2D2D);
  static const white                  = Color(0xFFF2F2F2);

  // --- Grays & Neutrals ---
  static const gray100               = Color(0xFFE9E9E9);
  static const gray200               = Color(0xFFCECECE);
  static const gray300               = Color(0xFFACACAC);
  static const gray500               = Color(0xFF646464);
  static const darkCharcoal          = Color(0xFF2A2A2A);
  static const creamWhite            = Color(0xFFF5E9E2);

  // --- Player Colors Palette ---
  // Reds & Pinks
  static const softRed               = Color(0xFFC94F4F);
  static const crimsonRed            = Color(0xFFC92A2A);
  static const wineRed               = Color(0xFF8C3A4A);
  static const dustyRose             = Color(0xFFC75A8A);

  // Blues & Purples
  static const denimBlue             = Color(0xFF4F7BC9);
  static const oceanBlue             = Color(0xFF116CB6);
  static const indigoBlue            = Color(0xFF5C63C7);
  static const lavenderPurple        = Color(0xFF8B5FBF);
  static const slateGray             = Color(0xFF64748B);

  // Greens & Teals
  static const meadowGreen           = Color(0xFF4FA85D);
  static const oliveGreen            = Color(0xFF7A9A3A);
  static const deepTeal              = Color(0xFF0B644C);
  static const turquoiseTeal         = Color(0xFF3FA7A3);

  // Yellows & Oranges
  static const burntOrange           = Color(0xFFD47A2A);
  static const vibrantOrange         = Color(0xFFE66B00);
  static const mustardGold           = Color(0xFFC9A227);
  static const goldenYellow          = Color(0xFFB8952E);

  static const List<int> playerPaletteValues = [
    0xFFC94F4F, // softRed
    0xFF4F7BC9, // denimBlue
    0xFF4FA85D, // meadowGreen
    0xFF8B5FBF, // lavenderPurple
    0xFFD47A2A, // burntOrange
    0xFF3FA7A3, // turquoiseTeal
    0xFFC9A227, // mustardGold
    0xFFC75A8A, // dustyRose
    0xFF5C63C7, // indigoBlue
    0xFF7A9A3A, // oliveGreen
    0xFF8C3A4A, // wineRed
    0xFFC92A2A, // crimsonRed
    0xFF116CB6, // oceanBlue
    0xFF0B644C, // deepTeal
    0xFFB8952E, // goldenYellow
    0xFFE66B00, // vibrantOrange
    0xFF64748B, // slateGray
  ];
}