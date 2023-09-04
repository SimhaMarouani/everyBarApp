import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageProvider extends StateNotifier<String> {
  LanguageProvider() : super('English');

  void setLanguage(String language) {
    state = language;
  }
}

final currentLanguageProvider =
    StateNotifierProvider<LanguageProvider, String>((ref) {
  return LanguageProvider();
});
