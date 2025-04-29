import 'package:flutter/material.dart';
import 'package:shivri/models/message.dart';

class InputTextContent extends MessageContent {
  final String text;
  final bool isFromUser;

  InputTextContent(this.text, {this.isFromUser = false});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isFromUser ? Colors.black : Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}