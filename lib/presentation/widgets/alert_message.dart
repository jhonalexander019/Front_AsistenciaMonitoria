import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const AlertMessage({
    Key? key,
    required this.message,
    required this.isSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
