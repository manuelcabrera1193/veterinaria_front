import 'package:flutter/material.dart';

class ButtonsBottomWidget extends StatelessWidget {
  final Function()? event;

  const ButtonsBottomWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.grey.shade300,
          onPressed: null,
          child: IconButton(
            color: Colors.green,
            onPressed: event,
            icon: const Icon(Icons.check),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.grey.shade300,
          onPressed: null,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
