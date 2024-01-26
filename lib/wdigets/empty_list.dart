import 'package:flutter/material.dart';
class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.task_rounded,
              size: 80.0, color: Color(0xff0D3257)),
          Container(
            padding: const EdgeInsets.only(top: 4.0),
            child: const Text(
              "Don't have any Todo",
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}