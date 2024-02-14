import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key,
    required this.onTap,
    required this.icon,
    this.color = Colors.white
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 1, color: Colors.white),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                blurRadius: 6,
                spreadRadius: 0.6,
                offset: const Offset(1, 1)),
            BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 8,
                spreadRadius: 0.4,
                offset: const Offset(-1, -1)),
          ],
          gradient: LinearGradient(
            colors: [
              kGrey.withOpacity(0.5),
              Colors.white,

            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 1],
          ),
        ),
        child: Icon(icon,
            shadows: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0.25, 0.3)),
              BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: -12,
                  offset: const Offset(-0.8, -0.8)),
            ],
            size: 34, color: color),
      ),
    );
  }
}

