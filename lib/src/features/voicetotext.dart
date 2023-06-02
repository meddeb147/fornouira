import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card with Text Field',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final stt.SpeechToText speech = stt.SpeechToText();
  String textFieldValue = '';
  int value = 0;
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
    _addCard(); // Add initial card when the page is first opened
  }

  void _addCard() {
    setState(() {
      int initialValue = (cards.length ) * 30; // Calculate initial value based on card index
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
      onStopListening: _stopListening,
      initialValue: initialValue,
    );
  }

  void _stopListening() {
    speech.stop();
  }

  void _startListening() {
    // Implement speech-to-text functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card with Text Field'),
      ),
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
  final VoidCallback onStopListening;
  final int initialValue;

  CustomCard({
    required this.textFieldValue,
    required this.onTextChanged,
    required this.onStopListening,
    required this.initialValue,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  int value = 0;

  @override
  void initState() {
    super.initState();
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
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: widget.onTextChanged,
              decoration: InputDecoration(
                labelText: 'Enter Text',
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Start Mic'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: widget.onStopListening,
                  child: Text('Stop Mic'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementValue,
                  child: Text('-'),
                ),
                SizedBox(width: 10.0),
                Text(value.toString()),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _incrementValue,
                  child: Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
