import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/company.dart';

class DetailScreen extends StatelessWidget {
  final Company company = Get.arguments as Company;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem('Company Name', company.name, Icons.business),
            _buildInfoItem('Industry', company.industry, Icons.work),

            _buildInfoItem('Address', company.address, Icons.location_on),
            _buildInfoItem('Country', company.country, Icons.flag)
            ,
            _buildInfoItem('Employees', '${company.employeeCount}', Icons.people),
            _buildInfoItem('CEO', company.ceoName, Icons.person),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,

                  ),
                ),
                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              ],

            ),
          ),

        ],
      ),

    );
  }
}