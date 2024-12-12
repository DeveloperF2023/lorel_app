import 'package:flutter/material.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CustomShimmer({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: -1.0, end: 1.0),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1.0,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + value, 0.0),
                      end: const Alignment(1.0, 0.0),
                      colors: [
                        Colors.grey[200]!,
                        Colors.grey[100]!,
                        Colors.grey[300]!,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          onEnd: () {
            TweenAnimationBuilder(
              tween: Tween(begin: -1.0, end: 1.0),
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return const SizedBox(); // This will be replaced by a new instance of TweenAnimationBuilder
              },
            );
          },
        ),
      ],
    );
  }
}
