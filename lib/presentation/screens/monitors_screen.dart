import 'package:flutter/material.dart';

import '../widgets/app_bar_content.dart';

class MonitorsScreen extends StatefulWidget{
  const MonitorsScreen({super.key});

  @override
  _MonitorsScreenState createState() => _MonitorsScreenState();
}

class _MonitorsScreenState extends State<MonitorsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: AppBarContent(title: 'Monitores'),
          
        ),
      ),
      body: const Center(
        child: Text('Monitores'),
      ),
    );
  }
}