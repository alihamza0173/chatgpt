import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String sender, text;
  final bool bot;
  const ChatMessage({super.key, required this.sender, required this.text, this.bot = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Container(
        color: sender == 'user'? const Color.fromARGB(255, 52, 52, 65): const Color.fromARGB(255, 68, 70, 84),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: sender == 'user'? Colors.red[200]: Colors.green[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:Text(sender, style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text, style: const TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
