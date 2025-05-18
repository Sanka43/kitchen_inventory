import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class SupplierListPage extends StatelessWidget {
  // Sample supplier data
  final List<Map<String, String>> suppliers = [
    {
      'name': 'ABC Supplies',
      'contact': '0771234567',
      'address': 'Colombo, Sri Lanka',
    },
    {
      'name': 'Global Traders',
      'contact': '0712345678',
      'address': 'Kandy, Sri Lanka',
    },
    {
      'name': 'Quick Logistics',
      'contact': '0756789012',
      'address': 'Galle, Sri Lanka',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier List'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.business, color: Colors.teal),
              title: Text(supplier['name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact: ${supplier['contact']}'),
                  Text('Address: ${supplier['address']}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
