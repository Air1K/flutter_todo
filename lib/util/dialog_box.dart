import 'package:first_project/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.send,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Задача",
                prefixIcon: const Icon(Icons.add),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Сохранить", onPressed: onSave),
                const SizedBox(width: 5,),
                MyButton(text: "Выйти", onPressed: onCancel)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
