import 'package:flutter/material.dart';
import 'dart:ui';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Tomatoes", "stock": 80, "maxStock": 100},
    {"name": "Potatoes", "stock": 50, "maxStock": 100},
    {"name": "Onions", "stock": 30, "maxStock": 100},
    {
      "name": "Milk",
      "stock": 10,
      "maxStock": 50
    }, // LOW STOCK (Shows Order Button)
    {
      "name": "Eggs",
      "stock": 5,
      "maxStock": 30
    }, // LOW STOCK (Shows Order Button)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Welcome, User!",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.kitchen),
              title: Text("Kitchen Inventory"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to Login Screen
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Cards (Horizontal)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildDashboardCard(
                          "Products", Icons.inventory, Colors.blue),
                      _buildDashboardCard(
                          "Categories", Icons.category, Colors.orange),
                      _buildDashboardCard(
                          "Suppliers", Icons.local_shipping, Colors.purple),
                      _buildDashboardCard(
                          "Reports", Icons.analytics, Colors.teal),
                      _buildDashboardCard(
                          "Orders", Icons.shopping_cart, Colors.red),
                    ],
                  ),
                ),
              ),

              // Stock Levels Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  "Stock Levels",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),

              // Stock Levels (Horizontal Scroll)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: stockItems
                      .map((item) => _buildStockItem(context, item))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Dashboard Cards
  Widget _buildDashboardCard(String title, IconData icon, Color color) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Rounding corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Transparent background
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50, color: color),
                    SizedBox(height: 10),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Stock Levels (Horizontal Cards)
  Widget _buildStockItem(BuildContext context, Map<String, dynamic> item) {
    double percentage = item["stock"] / item["maxStock"];
    Color progressColor = percentage > 0.5
        ? Colors.green
        : (percentage > 0.2 ? Colors.orange : Colors.red);

    return Container(
      width: 150,
      height: 400,
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Transparent background
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item["name"],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 5),
                  Container(
                    width: 20,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(" ${item["stock"]} / ${item["maxStock"]}",
                      style: TextStyle(color: Colors.white)),
                  if (percentage < 0.2)
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          _showOrderDialog(context, item["name"]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text("Order Now"),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Show Order Dialog
  void _showOrderDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Item"),
          content: Text("Do you want to order more $itemName?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$itemName order placed!")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
