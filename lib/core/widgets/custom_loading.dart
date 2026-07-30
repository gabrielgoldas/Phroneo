import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';

Widget customLoading(
    { double width = 46, Color color = AppColors.white}
) {
  return SvgPicture.asset(
    'assets/images/logo_phroneo_white.svg',
    width: width,
    colorFilter: ColorFilter.mode(
      color,
      BlendMode.srcIn,
    ),
  )
      .animate(onPlay: (controller) => controller.repeat())
      .rotate(duration: 2.seconds);
}
