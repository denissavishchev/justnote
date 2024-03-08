import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key,
    required this.isUser,
    required this.message,
    required this.date
  }) : super(key: key);

  final bool isUser;
  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.green : Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message,
          style: TextStyle(color: isUser ? Colors.red : Colors.black),),
          Text(date,
            style: TextStyle(color: isUser ? Colors.red : Colors.black),),
        ],
      ),
    );
  }
}


