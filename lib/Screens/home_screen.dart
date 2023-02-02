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

  // ChatGPT? chatGPT;

  // StreamSubscription? _subscription;

  Future<String> _getResponseFromAPI(String prompt) async {
    setState(() {
      _isTyping = true;
      _list.insert(0, ChatMessage(sender: 'user', text: _textController.text));
    });
    _textController.clear();

    const apiKey = apikey;
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 4000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      setState(() {
        _isTyping = false;
        _list.insert(
            0,
            ChatMessage(
                sender: 'bot', text: responseJson['choices'][0]['text']));
      });
      return 'Success';
    } else {
      setState(() {
        _isTyping = false;
      });
      return 'Failed to get response from API';
    }
  }

  // void _sendMessage() {
  //   setState(() {
  //     _list.insert(0, ChatMessage(sender: 'user', text: _textController.text));
  //   });
  //   _textController.clear();

  //   final request = CompleteReq(
  //       prompt: _textController.text,
  //       model: kTranslateModelV3,
  //       max_tokens: 200);

  //   try {
  //     _subscription = chatGPT!
  //         .builder('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')
  //         .onCompleteStream(request: request)
  //         .listen((response) {
  //       print(response!.choices[0].text);
  //       setState(() {
  //         _list.insert(
  //             0, ChatMessage(sender: 'bot', text: response.choices[0].text));
  //       });
  //     });
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // @override
  // void initState() {
  //   chatGPT = ChatGPT.instance;
  //   super.initState();
  // }

  @override
  void dispose() {
    // _subscription?.cancel();
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
              onFieldSubmitted: (value) {
                if (_textController.text.isEmpty) {
                  return;
                }
                _getResponseFromAPI(value);
                FocusScope.of(context).unfocus();
              },
              controller: _textController,
              enabled: !_isTyping,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    _getResponseFromAPI(_textController.text);
                    FocusScope.of(context).unfocus();
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
