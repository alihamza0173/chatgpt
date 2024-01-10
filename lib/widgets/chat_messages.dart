import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt/Screens/show_image.dart';
import 'package:chat_gpt/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessage extends StatelessWidget {
  final String sender;
  final String? text;
  final bool? txtToImg;
  final List? img;
  const ChatMessage(
      {super.key,
      required this.sender,
      this.text,
      this.txtToImg = false,
      this.img});

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
                  ? const CachedNetworkImageProvider(BOT_IMG)
                  : const CachedNetworkImageProvider(USER_IMG, scale: 0.5),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: txtToImg!
                    ? Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BeautifulImageScreen(
                                        img: img![0]['url'],
                                      ),
                                    ));
                              },
                              child: Hero(
                                tag: img![0]['url'],
                                child: CachedNetworkImage(
                                  imageUrl: img![0]['url'],
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BeautifulImageScreen(
                                        img: img![1]['url'],
                                      ),
                                    ));
                              },
                              child: Hero(
                                tag: img![1]['url'],
                                child: CachedNetworkImage(
                                  imageUrl: img![1]['url'],
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : MarkdownBody(
                        selectable: true,
                        data: text ?? 'null',
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
                          code: const TextStyle(color: Colors.red),
                          a: const TextStyle(color: Colors.white),
                          blockquote: const TextStyle(color: Colors.white),
                          blockSpacing: 10.0,
                          listIndent: 20.0,
                          blockquoteDecoration: const BoxDecoration(
                            color: Color.fromARGB(255, 52, 52, 65),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          codeblockPadding: const EdgeInsets.all(10.0),
                          codeblockDecoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
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
