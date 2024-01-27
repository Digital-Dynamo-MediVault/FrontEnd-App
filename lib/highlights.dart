import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

final Map<String, HighlightedWord> highlights = {
  'extreme': HighlightedWord(
    onTap: () => print('flutter'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  ),
  'headache': HighlightedWord(
    onTap: () => print('voice'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  ),
  'vomit': HighlightedWord(
    onTap: () => print('subscribe'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  ),
  'nausea': HighlightedWord(
    onTap: () => print('like'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
  'fever': HighlightedWord(
    onTap: () => print('comment'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  ),
  'cough': HighlightedWord(
    onTap: () => print('share'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
  ),
  'fatigue': HighlightedWord(
    onTap: () => print('play'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    ),
  ),
  'shortness of breath': HighlightedWord(
    onTap: () => print('download'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.teal,
      fontWeight: FontWeight.bold,
    ),
  ),
  'muscle ache': HighlightedWord(
    onTap: () => print('heart'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.redAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
  'loss of taste': HighlightedWord(
    onTap: () => print('star'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    ),
  ),
  'chills': HighlightedWord(
    onTap: () => print('flag'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.indigo,
      fontWeight: FontWeight.bold,
    ),
  ),
  'sore throat': HighlightedWord(
    onTap: () => print('bell'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.deepOrange,
      fontWeight: FontWeight.bold,
    ),
  ),
  'running nose': HighlightedWord(
    onTap: () => print('camera'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.cyan,
      fontWeight: FontWeight.bold,
    ),
  ),
  'diarrhoea': HighlightedWord(
    onTap: () => print('mic'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.brown,
      fontWeight: FontWeight.bold,
    ),
  ),
  'ulcer': HighlightedWord(
    onTap: () => print('mic'),
    textStyle: const TextStyle(
      fontSize: 32.0,
      color: Colors.pink,
      fontWeight: FontWeight.bold,
    ),
  ),
  // Add more symptoms as needed
};
