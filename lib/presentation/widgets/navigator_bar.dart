import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {
  final ValueChanged<int> onItemTapped;

  const NavigatorBar({super.key, required this.onItemTapped});

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(84, 22, 43, 1.0),
          type: BottomNavigationBarType.fixed,

        items: _buildNavigationItems(),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Inicio',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Monitores',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'Semestre',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.view_list_rounded),
        label: 'Asistencias',
      ),
    ];
  }
}
