enum JunctionWidgetSize {
  one,
  two,
  three,
  four;
}

extension JunctionWidgetSizeExtension on JunctionWidgetSize{
  double? get size{
    switch(this){
      case JunctionWidgetSize.one:
        return 100;
      case JunctionWidgetSize.two:
        return 200;
      case JunctionWidgetSize.three:
        return 300;
      case JunctionWidgetSize.four:
        return 400;
      default:
        return null;
    }
  }
}