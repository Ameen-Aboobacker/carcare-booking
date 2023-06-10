import 'package:carcareuser/services/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ScreenMainPage extends StatelessWidget {
  const ScreenMainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final nb = Provider.of<NavbarProvider>(context);
    return Scaffold(
      body: nb.items[nb.selectedIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
       showUnselectedLabels: true,
       unselectedFontSize: 10,
        currentIndex: nb.selectedIndex,
        onTap: (value) {
          nb.selectedIndex=value;
        },
        items: nb.items
            .map(
              (e) => BottomNavigationBarItem(
                 backgroundColor: Colors.purple,
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
