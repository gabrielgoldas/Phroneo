import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final String? filePath;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final String labelText;
  final VoidCallback onPressed;

  const CustomElevatedIconButton({
    super.key,
    this.filePath,
    this.icon,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    required this.labelText,
    required this.onPressed,
  }) : assert(filePath != null || icon != null, 'svgAsset ou icon deve ser informado');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      onPressed: onPressed,
      icon: (icon != null)
          ? Icon(icon)
          : SvgPicture.asset(filePath!, width: 24, height: 24),
      label: Text(labelText),
    );
  }
}