class HotKeyModel{
  String _hotKeyName;
  List<String> _hotKeyModifiers;
  String _hotKeyKey;
  String _hotKeyAction;

  HotKeyModel(this._hotKeyName, this._hotKeyModifiers, this._hotKeyKey, this._hotKeyAction);

  String get hotKeyName => _hotKeyName;
  List<String> get hotKeyModifiers => _hotKeyModifiers;
  String get hotKeyKey => _hotKeyKey;
  String get hotKeyAction => _hotKeyAction;

  set hotKeyName(value){
    if(!value){
      _hotKeyName = value;
    }
  }
  set hotKeyModifiers(value){
    if(!value){
      _hotKeyModifiers = value;
    }
  }
  set hotKeyKey(value){
    if(!value){
      _hotKeyKey = value;
    }
  }
  set hotKeyAction(value){
    if(!value){
      _hotKeyAction = value;
    }
  }
}