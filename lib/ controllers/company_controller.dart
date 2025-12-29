import 'package:get/get.dart';
import '../models/company.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class CompanyController extends GetxController {
  final ApiService apiService = ApiService();
  final LocalStorageService localStorage = Get.find();

  var companies = <Company>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCompanies();
  }

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

  void refreshData() {
    loadCompanies();
  }
}