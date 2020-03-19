import 'package:flutter/material.dart';

/// Draws a little dot as indicator.
class Ring extends StatelessWidget {
  /// [color] Determine the color of this circle.
  /// [size] Determine the circumference.
  Ring({Key key, this.color, this.size, this.innerColor}) : super(key: key);

  final Color color;
  final Color innerColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Container(
        width: size - 2,
        height: size - 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: innerColor,
        ),
      ),
    );
  }
}
