import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DatabaseHelper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Future<void> sendMessage(String message) async {
    bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No Internet Connection"),
            content: const Text(
                "Please check your internet connection and try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      _messages.add(".$message");
    });

    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyA7S3PRWWwav456RP10PoOWMoRGIhKkGW8'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "text":
                    "You are a health assistant chatbot named Tranquillo. \ If a user says 'hi', 'hello', or similar, reply with a friendly greeting. \If the user asks your name, say 'I'm Tranquillo'. \For any health questions, give advice and solutions in simple language. \Always include a disclaimer that you're not a licensed doctor and recommend visiting a real doctor for serious issues."
              }
            ]
          },
          {
            "role": "user",
            "parts": [
              {"text": message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body)['candidates'][0]['content'];

      final String generatedResponse = data['parts'][0]['text'];

      setState(() {
        _messages.add("$generatedResponse");
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  String? selectedAvatar;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await _dbHelper.getUsers();
    if (user.isNotEmpty) {
      setState(() {
        selectedAvatar = user[0]['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4.0,
        // centerTitle: true,
        backgroundColor: const Color.fromRGBO(188, 224, 240, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: selectedAvatar != null
                ? AssetImage(selectedAvatar!)
                : const AssetImage('assets/images/kaula.png'),
          ),
        ),
        title: Text(
          'Chat with Tranquillo',
          style: GoogleFonts.figtree(fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        // width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  'assets/images/appbg.png',
                ))),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUserMessage = _messages[index].startsWith(".");

                  return Row(
                    mainAxisAlignment: isUserMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      if (!isUserMessage)
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/kaula.png'),
                          backgroundColor: Colors.grey,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text('Suraj Kumar', style: Theme.of(context).textTheme.headline6),
                            Align(
                              alignment: !isUserMessage
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.only(
                                    top: 5.0, right: 10, bottom: 10),
                                child: Text(_messages[index]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isUserMessage)
                        CircleAvatar(
                          backgroundImage: AssetImage(selectedAvatar!),
                          backgroundColor: Colors.white,
                        ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      // onSubmitted: _handleSubmitted,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Send a message..."),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String message = _controller.text.trim();
                      if (message.isNotEmpty) {
                        sendMessage(message);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
