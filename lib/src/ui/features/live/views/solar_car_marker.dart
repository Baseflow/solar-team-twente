import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';

class SolarCarMarker extends StatelessWidget {
  const SolarCarMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(Sizes.s96),
            border: Border.all(
              color: context.colorScheme.primary,
              width: Sizes.s2,
            ),
          ),
          child: SvgPicture.asset(
            Assets.icons.solarCarIcon,
            semanticsLabel: 'Solarteam Car',
          ),
        ),
        // Paint a custom small triangle here, upside down.
        CustomPaint(
          size: const Size(Sizes.s24, Sizes.s8),
          painter: _TrianglePainter(context.colorScheme.primary),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
