import 'package:chat_flutter/config/app_radius.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/config/app_text_size.dart';
import 'package:flutter/material.dart';

class InputMessageTextField extends StatelessWidget {
  const InputMessageTextField({this.roomTextController});
  final TextEditingController roomTextController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: roomTextController,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(AppRadius.midium),
          ),
          contentPadding: const EdgeInsets.all(
            AppSpace.small,
          ),
        ),
        style: const TextStyle(
          fontSize: AppTextSize.midium,
        ),
      ),
    );
  }
}
