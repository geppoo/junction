import 'dart:ui';

///Class that define the basic theme values for the application
//TODO: add more options for more customization
class ThemeVariant {
  String variantId;
  Color primary;
  Color onPrimary;
  Color secondary;
  Color onSecondary;

  ThemeVariant(
    this.variantId,
    this.primary,
    this.onPrimary,
    this.secondary,
    this.onSecondary,
  );
}
