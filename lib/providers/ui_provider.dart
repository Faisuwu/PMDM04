//ui_provider.dart - Antoni Maqueda DI04

import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier{
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }
  set selectedMenuOpt(int index){
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}