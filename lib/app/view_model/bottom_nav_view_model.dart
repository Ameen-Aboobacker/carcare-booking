import 'package:flutter/cupertino.dart';

class BottomBarViewModel with ChangeNotifier {
  int _bottomBarIndex = 0;

  int get newIndex => _bottomBarIndex;

  bottomOnChanged(int index) {
    _bottomBarIndex = index;
    notifyListeners();
  }

  changeBottomNavindex(int changIndex) {
    _bottomBarIndex = changIndex;
    notifyListeners();
  }
}
