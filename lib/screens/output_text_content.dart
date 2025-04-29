import 'package:flutter/material.dart';
import 'package:shivri/models/message.dart';

class OutputTextContent extends MessageContent {
  final String text;

  OutputTextContent(this.text);

  @override
  Widget buildContent(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}

