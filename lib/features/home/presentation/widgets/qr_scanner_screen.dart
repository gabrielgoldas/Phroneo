import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/home/presentation/widgets/scanner_overlay_painter.dart';

import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _isScanned = false;

  @override
  Widget build(BuildContext context) {
    final scanWindowSize = MediaQuery.of(context).size.width * 0.7; // 70% da largura da tela
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: scanWindowSize,
      height: scanWindowSize,
    );

    return Scaffold(
      appBar: CustomAppBar(backgroundColor: Colors.transparent,),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [

          MobileScanner(
              onDetect: (BarcodeCapture capture) {
                if (_isScanned) return;

                // Get codes list
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  final String? code = barcodes.first.rawValue;

                  if (code != null && code.isNotEmpty) {
                    setState(() => _isScanned = true);
                    context.pop(code);
                  }
                }
              }
          ),

          CustomPaint(
            painter: ScannerOverlayPainter(scanWindow: scanWindow),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15, // 15% acima do fim da tela
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Alinhe o QR Code no centro',
                style: TextStyle(
                  fontFamily: AppFonts.cormorantInfant,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.titleSmall,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}