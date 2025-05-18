import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'product.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'login_screen.dart';
import 'supplier_list_page.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Rice", "stock": 49, "maxStock": 200},
    {"name": "Dhal", "stock": 70, "maxStock": 80},
    {"name": "Sugar", "stock": 21, "maxStock": 100},
    {"name": "Salt", "stock": 35, "maxStock": 50},
    {"name": "Oil", "stock": 12, "maxStock": 20},
  ];

  final List<double> dailyUsage = [30, 45, 28, 55, 40, 65, 50];

  DashboardScreen({Key? key}) : super(key: key);

  Map<String, double> getStockDataForPieChart() {
    Map<String, double> data = {};
    for (var item in stockItems) {
      data[item["name"]] = item["stock"].toDouble();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final stockData = getStockDataForPieChart();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Kitchen World',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 14, 7),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 1, 14, 7),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              accountName: Text(
                "Sanka Eranga",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              accountEmail: Text(
                "isankaerangahtc820@gmail.com",
                style: GoogleFonts.poppins(),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text("Edit Profile", style: GoogleFonts.poppins()),
              onTap: () {
                // Navigate to Edit Profile screen (implement as needed)
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Edit Profile tapped")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text("Log Out", style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Logged out")));
              },
            ),
          ],
        ),
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
                      _buildPiechartCard(context, stockData),
                      const SizedBox(height: 20),
                      _buildQuickAccessButton(context),
                      const SizedBox(height: 20),
                      _buildLineChartCard(),
                      const SizedBox(height: 20),
                      _buildLowStockList(),
                      const SizedBox(height: 100),
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
                    _buildBottomButton(Icons.home, "Home",  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    },),
                    _buildBottomButton(Icons.inventory, "Stock", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SupplierListPage()),
                      );
                    }),
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

  Widget _buildPiechartCard(
    BuildContext context,
    Map<String, double> stockData,
  ) {
    final colorList = [
      Colors.blue[300]!,
      Colors.green[300]!,
      Colors.orange[300]!,
      Colors.red[300]!,
      Colors.purple[300]!,
    ];
    final keys = stockData.keys.toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections:
                        stockData.entries.map((entry) {
                          int index = keys.indexOf(entry.key);
                          return PieChartSectionData(
                            value: entry.value,
                            title: '${entry.key}\n${entry.value.toInt()}',
                            color: colorList[index % colorList.length],
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            radius: 60,
                          );
                        }).toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineChartCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
              width: 2,
            ),
      ),
      child: Column(
        
        children: [
          Text(
            "Usage",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        final days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            days[value.toInt() % 7],
                            style: const TextStyle(fontSize: 10,color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: List.generate(
                      dailyUsage.length,
                      (index) => FlSpot(index.toDouble(), dailyUsage[index]),
                    ),
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color.fromARGB(255, 1, 82, 44).withOpacity(0.2),
                    ),
                    color: const Color.fromARGB(255, 0, 255, 136),
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildDashboardCard(
              "Products",
              Icons.inventory,
              const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Product()),
                );
              },
            ),
            _buildDashboardCard(
              "Suppliers",
              Icons.local_shipping,
              const Color.fromARGB(255, 255, 255, 255),
            ),
            _buildDashboardCard(
              "Reports",
              Icons.analytics,
              const Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    IconData icon,
    Color color, {
    VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
              width: 2,
            ),
          ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: color),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildStockItem(BuildContext context, Map<String, dynamic> item) {
    double percentage = item["stock"] / item["maxStock"];
    Color progressColor =
        percentage > 0.5
            ? Colors.green
            : (percentage > 0.2 ? Colors.orange : Colors.red);

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                item["name"],
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: (percentage * 100).clamp(0, 100).toInt(),
                stepSize: 10,
                arcSize: 3.14 * 2,
                selectedColor: progressColor,
                unselectedColor: Colors.grey.shade300,
                padding: 0,
                width: 100,
                height: 100,
                roundedCap: (_, __) => true,
                child: Center(
                  child: Text(
                    "${(percentage * 100).toInt()}%",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text("${item["stock"]}", style: const TextStyle(fontSize: 14)),
              if (percentage < 0.2)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () => _showOrderDialog(context, item["name"]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Order Now"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLowStockList() {
    final lowStockItems =
        stockItems
            .where((item) => item["stock"] / item["maxStock"] < 0.25)
            .toList();

    if (lowStockItems.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
              width: 2,
            ),
        ),
        child: Text(
          "All stock levels are sufficient.",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
              width: 2,
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Low Stock",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 12),
          ...lowStockItems.map((item) {
            final double percent = item["stock"] / item["maxStock"];
            final percentText = (percent * 100).toStringAsFixed(0);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["name"], style: GoogleFonts.poppins(fontSize: 16,color: Colors.white)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: percent,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percent < 0.25 ? Colors.red :  Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$percentText% of ${item["maxStock"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showOrderDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order $itemName"),
          content: Text("Do you want to place a new order for $itemName?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order placed for $itemName")),
                );
              },
              child: const Text("Order"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)), onPressed: onTap),
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF))),
      ],
    );
  }
}
