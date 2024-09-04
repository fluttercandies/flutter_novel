import 'package:flutter/material.dart';

class LinearGradientColorText extends StatelessWidget {
  const LinearGradientColorText({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => const LinearGradient(
        colors: [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.pink,
          Colors.yellow,
        ],
      ).createShader(bounds),
      child: const Text(
        'You have pushed the button this many times:',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
