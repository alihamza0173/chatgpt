import 'dart:ui';

import 'package:chat_gpt/Screens/chatgpt.dart';
import 'package:chat_gpt/Screens/text_to_img.dart';
import 'package:chat_gpt/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://spearheadtech.io/wp-content/uploads/2022/04/hyperautomation.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            )),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                text: 'ChatGPT',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatGPT()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Text To Image',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TxtToImg()),
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
