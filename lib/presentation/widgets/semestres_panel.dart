import 'package:flutter/material.dart';

import 'app_bar_content.dart';

class SemestresPanel extends StatefulWidget{
  const SemestresPanel({super.key});

  @override
  _SemestresPanelState createState() => _SemestresPanelState();
}

class _SemestresPanelState extends State<SemestresPanel>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: AppBarContent(title: 'Semestres'),
        ),
      ),
      body: const Center(
        child: Text('Semestres'),
      ),
    );
  }
}