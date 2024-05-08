import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../assets/generated/assets.gen.dart';

/// The background image displayed on the profile page.
class ProfileBackground extends StatelessWidget {
  /// Creates a new [ProfileBackground] instance.
  const ProfileBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200, bottom: 24),
      child: Transform.rotate(
        angle: -0.3,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.baseflowLogo.path),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
