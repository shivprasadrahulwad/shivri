
import 'package:flutter/material.dart';
import 'package:shivri/models/message.dart';

class BulletListContent extends MessageContent {
  BulletListContent();

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bulletItem('Implement theme customization'),
              _bulletItem('Add LLM behavior preferences'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '14. Finalize performance optimizations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bulletItem('Implement caching strategies'),
              _bulletItem('Optimize API usage to reduce costs'),
              _bulletItem('Add offline capabilities where possible'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '15. Prepare for deployment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bulletItem('Set up CI/CD pipeline'),
              _bulletItem('Configure app signing'),
              _bulletItem('Prepare store listings and marketing materials'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Would you like me to expand on any particular phase or step in more detail?',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}