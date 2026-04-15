import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/company.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

/// GetX controller that manages company data, search, favorites, and theme.
class CompanyController extends GetxController {
  final ApiService apiService = ApiService();
  final LocalStorageService localStorage = Get.find();

  /// Full list of companies fetched from the API.
  var companies = <Company>[].obs;

  /// True while data is being loaded.
  var isLoading = true.obs;

  /// Holds an error message if the API call fails.
  var errorMessage = ''.obs;

  /// Current search query entered by the user.
  var searchQuery = ''.obs;

  /// When true, only favorited companies are shown.
  var showFavoritesOnly = false.obs;

  /// Current dark mode state.
  var isDarkMode = false.obs;

  /// Returns companies filtered by search query and favorites toggle.
  List<Company> get filteredCompanies {
    return companies.where((c) {
      final matchesSearch =
          c.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          c.industry.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesFavorite = showFavoritesOnly.value ? c.isFavorite : true;
      return matchesSearch && matchesFavorite;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    // Restore saved dark mode preference on startup
    isDarkMode.value = localStorage.getDarkMode();
    loadCompanies();
  }

  /// Fetches companies from the API and merges with local favorites.
  Future<void> loadCompanies() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await apiService.fetchCompanies();
      final favorites = localStorage.getFavorites();

      companies.value = data.map((json) {
        final company = Company.fromJson(json);
        company.isFavorite = favorites.contains(company.id);
        return company;
      }).toList();
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Toggles the favorite state of a company and persists the change.
  void toggleFavorite(int companyId) {
    final index = companies.indexWhere((c) => c.id == companyId);
    if (index != -1) {
      if (companies[index].isFavorite) {
        localStorage.removeFavorite(companyId);
      } else {
        localStorage.addFavorite(companyId);
      }
      companies[index].isFavorite = !companies[index].isFavorite;
      companies.refresh();
    }
  }

  /// Switches between light and dark mode and saves the preference.
  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    localStorage.saveDarkMode(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Re-fetches company data from the API.
  void refreshData() {
    loadCompanies();
  }
}
