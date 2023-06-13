import 'package:flutter/cupertino.dart';

class BottomNavViewModel with ChangeNotifier {
  int _bottomBarIndex = 0;

  int get bottomBarIndex => _bottomBarIndex;

  bottomOnChanged(int index) {
    _bottomBarIndex = index;
    notifyListeners();
  }

  changeBottomNavindex(int changIndex) {
    _bottomBarIndex = changIndex;
    notifyListeners();
  }
}
