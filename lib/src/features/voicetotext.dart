import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card with Text Field',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Set the app's brightness to dark
      ),
      home: CardPage(),
    );
  }
}

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  
  String textFieldValue = '';
  int value = 0;
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
    _addCard();
    
  }

  void _addCard() {
    setState(() {
      int initialValue = cards.length * 30; // Calculate initial value based on card index
      cards.add(_buildCustomCard(cards.length, initialValue));
    });
  }

  Widget _buildCustomCard(int cardIndex, int initialValue) {
    return CustomCard(
      textFieldValue: textFieldValue,
      onTextChanged: (value) {
        setState(() {
          textFieldValue = value;
        });
      },
      initialValue: initialValue,
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      backgroundColor: Color(0xFF161B22),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return cards[index];
        },
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String textFieldValue;
  final Function(String) onTextChanged;
  final int initialValue;

  CustomCard({
    required this.textFieldValue,
    required this.onTextChanged,
    required this.initialValue,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  int value = 0;
  late stt.SpeechToText _speech;
  String recognizedSpeech = '';
  

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    value = widget.initialValue;
  }

  void _incrementValue() {
    setState(() {
      value += 10;
    });
  }

  void _decrementValue() {
    setState(() {
      value -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15.0,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: widget.onTextChanged,
              style: TextStyle(color: Colors.white),
              // Set the text color to white
              decoration: InputDecoration(
                labelText: 'Enter Text',
                labelStyle: TextStyle(
                  color: Colors.white,
                ), // Set the label text color to white
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ), // Set the border color to blue
                ),
              ),
              controller: TextEditingController(text: recognizedSpeech),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'value: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Set the text color to white
                  ),
                ),
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the text color to white
                  ),
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: _decrementValue,
                    icon: Icon(Icons.remove),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: _incrementValue,
                    icon: Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.0),
                SizedBox(width: 20.0), // Add a space between the buttons and the mic icon
                AvatarGlow(
                  endRadius: 20.0,
                  animate: _speech.isListening,
                  duration: Duration(milliseconds: 500),
                  glowColor: Color.fromARGB(255, 12, 76, 37),
                  repeat: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  showTwoGlows: true,
                  child: GestureDetector(
                    onTapDown: (details) async {
                      if (!_speech.isListening) {
                        bool available = await _speech.initialize(
                          onStatus: (status) {
                            print('status: $status');
                          },
                          onError: (error) {
                            print('error: $error');
                          },
                        );
                        if (available) {
                          setState(() {
                            _speech.listen(
                              onResult: (result) {
                                setState(() {
                                  recognizedSpeech = result.recognizedWords;
                                  print(recognizedSpeech);
                                });
                              },
                              
                            );
                          });
                        }
                      }
                    },
                    onTapUp: (details) async {
                      setState(() {
                        _speech.stop();
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 35,
                      child: Icon(Icons.mic),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

