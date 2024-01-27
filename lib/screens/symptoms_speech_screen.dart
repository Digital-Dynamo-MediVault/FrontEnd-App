import 'package:flutter/material.dart';
import 'package:medivault/constants.dart';
import 'package:medivault/highlights.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:dio/dio.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              title:
                  Text('Confidence: ${(_confidence * 100).toStringAsFixed(1)}'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarGlow(
                  animate: _isListening,
                  glowColor: kPrimaryColor,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  child: FloatingActionButton(
                    backgroundColor: kPrimaryColor,
                    onPressed: _listen,
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                ),
                FloatingActionButton(
                  tooltip: "Upload symptoms",
                  backgroundColor: kPrimaryColor,
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    final pref = await SharedPreferences.getInstance();
                    final pid = pref.getString("pid");

                    await Dio().post(
                        "https://embarrassed-twill-dog.cyclic.app/case/addextrasymptom",
                        data: {
                          "pId": pid,
                          "symptom": _text,
                        });
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.upload,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                child: TextHighlight(
                  text: _text,
                  words: highlights,
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        finalTimeout: Duration(seconds: 1),
        onStatus: (val) {
          print('onStatus: ${val == "done"}');
          if (val == "done") {
            setState(() => _isListening = false);
            _speech.stop();
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void startListening() async {
    bool available = await _speech.initialize(
      finalTimeout: Duration(seconds: 1),
      onStatus: (val) {
        print('onStatus: ${val == "done"}');
        if (val == "done") {
          setState(() => _isListening = false);
          _speech.stop();
        }
      },
      onError: (val) => print('onError: $val'),
    );
    print(available);
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
        }),
      );
    }
  }
}
