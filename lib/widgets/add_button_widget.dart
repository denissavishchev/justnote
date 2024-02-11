import 'package:flutter/material.dart';
import '../constants.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 70,
        alignment: Alignment.center,
        decoration: insetDecoration.copyWith(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(width: 0.3, color: kGrey.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  spreadRadius: 0.5,
                  offset: const Offset(2, 2)),
              const BoxShadow(
                  color: Colors.white,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(-2, -2)),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.grey.withOpacity(0.4),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: const [0.2, 1.0],
            ),
          ),
          child: Icon(
              Icons.add_circle_rounded,
              shadows: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: 1,
                    spreadRadius: 2,
                    offset: const Offset(0.6, 0.6)),

                BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: -12,
                    offset: const Offset(-0.8, -0.8)),
              ],
              size: 44, color: Colors.white),
        ),
      ),
    );
  }
}

