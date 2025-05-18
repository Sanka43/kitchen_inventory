import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';

class Product extends StatelessWidget {
  Product({super.key});

  // Make the list non-final to allow adding new products
  final List<Map<String, dynamic>> productList = [
    {"name": "Rice", "stock": 49, "maxStock": 200},
    {"name": "Dhal", "stock": 45, "maxStock": 80},
    {"name": "Sugar", "stock": 98, "maxStock": 100},
    {"name": "Salt", "stock": 35, "maxStock": 50},
    {"name": "Oil", "stock": 12, "maxStock": 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: Container(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products',
              border: InputBorder.none,
              hintStyle:
                  TextStyle(color: const Color.fromARGB(120, 255, 255, 255)),
              contentPadding: EdgeInsets.all(10),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (query) {
              // You can add your search logic here
              // For now, just print the query
              print('Search query: $query');
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 14, 7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/dashboard_backgraund_2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductList(productList),
                      _buildQuickAccessButton(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomButton(Icons.home, "Home", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    }),
                    _buildBottomButton(Icons.inventory, "Stock", () {}),
                    _buildBottomButton(Icons.list_alt, "Orders", () {}),
                    _buildBottomButton(Icons.settings, "Settings", () {}),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> productList) {
    return Column(
      children: productList.map((product) {
        final stock = product["stock"];
        final maxStock = product["maxStock"];
        final percent = stock / maxStock;
        final percentText = (percent * 100).toStringAsFixed(1);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 6,
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
          shadowColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 12,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      percent < 0.3
                          ? Colors.redAccent
                          : percent < 0.7
                              ? Colors.amber
                              : Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stock: $stock / $maxStock",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "$percentText%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: percent < 0.3
                            ? Colors.red
                            : percent < 0.7
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildQuickAccessIcon(Icons.add, "Add", () {
          _showAddProductDialog(context);
        }),
        _buildQuickAccessIcon(Icons.remove, "Remove", () {}),
      ],
    );
  }

  Widget _buildQuickAccessIcon(
      IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: onTap,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
        ),
      ],
    );
  }

  Widget _buildBottomButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: onTap,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
        ),
      ],
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController maxQtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: maxQtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Max Quantity"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                final String name = nameController.text.trim();
                final int? maxQty = int.tryParse(maxQtyController.text.trim());

                if (name.isNotEmpty && maxQty != null && maxQty > 0) {
                  productList.add({
                    "name": name,
                    "stock": 0,
                    "maxStock": maxQty,
                  });

                  Navigator.of(context).pop();
                  (context as Element).markNeedsBuild();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
