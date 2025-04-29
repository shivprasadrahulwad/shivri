import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmit;

  const InputBar({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey[700]!),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildAddButton(),
          const SizedBox(width: 10),
          _buildDivider(),
          const SizedBox(width: 10),
          _buildTextField(),
          const SizedBox(width: 10),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return IconButton(
      icon: const Icon(Icons.add,),
      onPressed: () {},
      color: Colors.grey,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey[700],
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Reply to Claude...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(color: Colors.white),
        minLines: 1,
        maxLines: 5,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC97C5D),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_upward),
        onPressed: () {
          onSubmit(controller.text);
        },
        color: Colors.white,
      ),
    );
  }
}