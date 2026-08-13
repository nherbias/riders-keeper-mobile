import 'package:flutter/material.dart';

class MDGoogleIcon extends StatelessWidget {
  const MDGoogleIcon({this.size = 18, super.key});

  static const assetPath = 'assets/images/branding/google_g.png';

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: 'Google',
    );
  }
}
