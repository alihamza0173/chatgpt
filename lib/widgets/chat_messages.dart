import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessage extends StatelessWidget {
  final String sender, text;
  final bool bot;
  const ChatMessage(
      {super.key, required this.sender, required this.text, this.bot = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Container(
        color: sender == 'user'
            ? const Color.fromARGB(255, 52, 52, 65)
            : const Color.fromARGB(255, 68, 70, 84),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[400],
              backgroundImage: sender == 'user'
                  ? const CachedNetworkImageProvider(
                      'https://icon-note.com/wp-content/uploads/2020/02/icon_human_010.png',
                      scale: 0.1)
                  : const CachedNetworkImageProvider(
                      'https://1000logos.net/wp-content/uploads/2023/02/ChatGPT-Logo.png'),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: MarkdownBody(
                  selectable: true,
                  data: text,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: Colors.white),
                    h1: const TextStyle(color: Colors.white),
                    h2: const TextStyle(color: Colors.white),
                    h3: const TextStyle(color: Colors.white),
                    h4: const TextStyle(color: Colors.white),
                    h5: const TextStyle(color: Colors.white),
                    h6: const TextStyle(color: Colors.white),
                    em: const TextStyle(color: Colors.white),
                    strong: const TextStyle(color: Colors.white),
                    code: const TextStyle(color: Colors.green),
                    a: const TextStyle(color: Colors.white),
                    blockquote: const TextStyle(color: Colors.white),
                    blockSpacing: 10.0,
                    listIndent: 20.0,
                    blockquoteDecoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 52, 65),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    codeblockPadding: const EdgeInsets.all(10.0),
                    codeblockDecoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 52, 65),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
