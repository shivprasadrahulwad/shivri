import 'package:flutter/material.dart';

class Message {
  final bool isFromUser;
  final MessageContent content;
  final DateTime timestamp;
  final MessageContent options;

  Message({
    required this.isFromUser,
    required this.content,
    required this.timestamp,
    required this.options,
  });
}

abstract class MessageContent {
  Widget buildContent(BuildContext context);
}

