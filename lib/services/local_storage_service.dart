import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting app data locally using SharedPreferences.
/// Handles favorites, user info, and theme preference.
class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;

  /// Initializes SharedPreferences instance.
  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Adds a company ID to the favorites list.
  Future<void> addFavorite(int companyId) async {
    final favorites = getFavorites();
    favorites.add(companyId);
    await saveFavorites(favorites);
  }

  /// Removes a company ID from the favorites list.
  Future<void> removeFavorite(int companyId) async {
    final favorites = getFavorites();
    favorites.remove(companyId);
    await saveFavorites(favorites);
  }

  /// Returns the list of favorited company IDs.
  List<int> getFavorites() {
    final favoriteStrings = _prefs.getStringList('favorites') ?? [];
    return favoriteStrings.map((id) => int.parse(id)).toList();
  }

  /// Persists the full favorites list to storage.
  Future<void> saveFavorites(List<int> favorites) async {
    await _prefs.setStringList(
      'favorites',
      favorites.map((id) => id.toString()).toList(),
    );
  }

  /// Returns true if the given company ID is in favorites.
  bool isFavorite(int companyId) {
    return getFavorites().contains(companyId);
  }

  /// Saves the user's name and email for feedback form auto-fill.
  Future<void> saveUserInfo(String name, String email) async {
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
  }

  /// Returns the saved user name, or null if not set.
  String? getUserName() => _prefs.getString('user_name');

  /// Returns the saved user email, or null if not set.
  String? getUserEmail() => _prefs.getString('user_email');

  /// Returns the saved dark mode preference (default: false).
  bool getDarkMode() => _prefs.getBool('dark_mode') ?? false;

  /// Persists the dark mode preference.
  Future<void> saveDarkMode(bool value) async =>
      await _prefs.setBool('dark_mode', value);
}
