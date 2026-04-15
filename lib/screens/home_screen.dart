import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ controllers/company_controller.dart';
import '../models/company.dart';
import 'detail_screen.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Directory'),
        actions: [
          // Dark mode toggle
          Obx(() => IconButton(
                icon: Icon(controller.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: controller.toggleDarkMode,
                tooltip: 'Toggle dark mode',
              )),
          // Favorites filter
          Obx(() => IconButton(
                icon: Icon(
                  controller.showFavoritesOnly.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.showFavoritesOnly.value ? Colors.red : null,
                ),
                onPressed: () => controller.showFavoritesOnly.value =
                    !controller.showFavoritesOnly.value,
                tooltip: 'Show favorites',
              )),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.feedback),
            onPressed: () => Get.to(() => const FeedbackScreen()),
            tooltip: 'Feedback',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or industry...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => controller.searchQuery.value = value,
            ),
          ),
          // Company list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 50, color: Colors.red),
                      const SizedBox(height: 10),
                      Text('Error: ${controller.errorMessage.value}'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.refreshData,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              final list = controller.filteredCompanies;

              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 50, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        controller.showFavoritesOnly.value
                            ? 'No favorites yet'
                            : 'No companies found',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) =>
                    CompanyCard(company: list[index]),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final CompanyController controller = Get.find();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            company.name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          company.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${company.industry} • ${company.country}'),
        trailing: IconButton(
          icon: Icon(
            company.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: company.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () => controller.toggleFavorite(company.id),
        ),
        onTap: () => Get.to(() => DetailScreen(), arguments: company),
      ),
    );
  }
}
