import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ controllers/company_controller.dart';
import '../models/company.dart';
import 'detail_screen.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatelessWidget {
  final CompanyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Directory'),
        actions: [IconButton(
            icon:  const Icon(Icons.refresh),
            onPressed: controller.refreshData

        ),

          IconButton(
            icon:  const Icon(Icons.feedback),
            onPressed: () => Get.to(() => FeedbackScreen()),
          ),
        ],
      ),
      body: Obx(() {
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

        return ListView.builder(
          itemCount: controller.companies.length,
          itemBuilder: (context, index) {
            final company = controller.companies[index];
            return CompanyCard(company: company);
          },
        );
      }),
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
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Text(
            company.name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          company.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(company.industry),
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