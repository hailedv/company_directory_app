import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }


  Future<void> addFavorite(int companyId) async {
    final favorites = getFavorites();
    favorites.add(companyId);
    await saveFavorites(favorites);
  }

  Future<void> removeFavorite(int companyId) async {
    final favorites = getFavorites();
    favorites.remove(companyId);
    await saveFavorites(favorites);
  }

  List<int> getFavorites() {
    final favoriteStrings = _prefs.getStringList('favorites') ?? [];
    return favoriteStrings.map((id) => int.parse(id)).toList();
  }

  Future<void> saveFavorites(List<int> favorites) async {
    await _prefs.setStringList(
      'favorites',
      favorites.map((id) => id.toString()).toList(),
    );
  }

  bool isFavorite(int companyId) {
    return getFavorites().contains(companyId);
  }


  Future<void> saveUserInfo(String name, String email) async {
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
  }

  String? getUserName() => _prefs.getString('user_name');
  String? getUserEmail() => _prefs.getString('user_email');
}