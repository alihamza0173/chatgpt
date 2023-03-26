import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt/const.dart';
import 'package:chat_gpt/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();
  final List<ChatMessage> _list = [];
  bool _isTyping = false;

  Future<String> _getResponseFromAPI(String prompt) async {
    setState(() {
      _isTyping = true;
      _list.insert(0, ChatMessage(sender: 'user', text: _textController.text));
    });
    _textController.clear();

    const apiKey = apikey;
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": prompt}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final content = responseJson['choices'][0]['message']['content'];
      setState(() {
        _isTyping = false;
        _list.insert(0, ChatMessage(sender: 'bot', text: content));
      });
      return 'Success';
    } else {
      setState(() {
        _isTyping = false;
      });
      return 'Failed to get response from API';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 68, 70, 84),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 33, 35),
        title: const Text('ChatGPT'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return _list[index];
                }),
          ),
          // ignore: prefer_const_constructors
          if (_isTyping)
            const SpinKitThreeBounce(
              color: Colors.black,
              size: 20.0,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: TextFormField(
              onFieldSubmitted: (value) async {
                if (_textController.text.isEmpty) {
                  return;
                }
                String res = await _getResponseFromAPI(value);
                if (res == 'Failed to get response from API') {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(res),
                    duration: const Duration(seconds: 1),
                  ));
                }
              },
              controller: _textController,
              enabled: !_isTyping,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    String res =
                        await _getResponseFromAPI(_textController.text);
                    if (res == 'Failed to get response from API') {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(res),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  },
                ),
                hintText: 'Send your query',
                hintStyle: const TextStyle(color: Colors.white),
                fillColor: const Color.fromARGB(255, 68, 70, 84),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
