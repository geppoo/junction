import 'package:junction/config/theme/theme_variant.dart';

///Class that defines the theme option configuration structure in the settings file
class CustomTheme {
  String id;
  List<ThemeVariant> variants;

  CustomTheme(
    this.id,
    this.variants,
  );

  ///Method to get the active theme variant for the active theme
  ThemeVariant? getActiveVariant(String variantId){
    for (ThemeVariant variant in variants){
      if (variant.variantId == variantId){
        return variant;
      }
    }
    return null;
  }
}
