import 'package:flutter/material.dart';

import 'admin_screen.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: GestureDetector(
        
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
            (Route<dynamic> route) => false,
          );
        },
        child: RichText(
          text: const TextSpan(
            text: '¿Ya tienes una cuenta? ',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Wondercity',
            ),
            children: [
              TextSpan(
                text: 'Inicia sesión',
                style: TextStyle(
                  color: Colors.green, // Color solo para "Inicia sesión"
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Wondercity',
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
