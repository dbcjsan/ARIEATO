import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final bool isPositive;

  const StatsCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Row(
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      change,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory StatsCardWidget.totalRevenue() {
    return const StatsCardWidget(
      title: 'Total Revenue',
      value: '\$45,231',
      change: '+12.5%',
      icon: FontAwesomeIcons.dollarSign,
      color: Colors.green,
      isPositive: true,
    );
  }

  factory StatsCardWidget.totalUsers() {
    return const StatsCardWidget(
      title: 'Total Users',
      value: '2,345',
      change: '+8.1%',
      icon: FontAwesomeIcons.users,
      color: Colors.blue,
      isPositive: true,
    );
  }

  factory StatsCardWidget.totalOrders() {
    return const StatsCardWidget(
      title: 'Total Orders',
      value: '1,234',
      change: '-2.4%',
      icon: FontAwesomeIcons.cartShopping,
      color: Colors.orange,
      isPositive: false,
    );
  }

  factory StatsCardWidget.conversionRate() {
    return const StatsCardWidget(
      title: 'Conversion Rate',
      value: '3.24%',
      change: '+0.8%',
      icon: FontAwesomeIcons.chartLine,
      color: Colors.purple,
      isPositive: true,
    );
  }
}