import 'package:junction/config/theme/theme_variant.dart';

import 'custom_theme.dart';

///Class that define theme option configuration structure in the settings file
class CustomThemeSettingsModel {
  String activeThemeId;
  String activeThemeVariantId;
  List<CustomTheme> themes;

  CustomThemeSettingsModel(
    this.activeThemeId,
    this.activeThemeVariantId,
    this.themes,
  );

  ///Method to get the active theme variant from the theme settings
  ThemeVariant? getActiveThemeVariant() {
    for (CustomTheme theme in themes) {
      if (theme.id == activeThemeId) {
        return theme.getActiveVariant(activeThemeVariantId);
      }
    }
    return null;
  }
}
