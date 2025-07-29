import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final String title;
  final String subtitle;
  final Color barColor;

  const BarChartWidget({
    super.key,
    required this.barGroups,
    this.title = 'Monthly Revenue',
    this.subtitle = 'Last 6 months',
    this.barColor = Colors.blue,
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
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '\$${value.toInt()}k',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                          return Text(
                            months[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: barGroups,
                  minY: 0,
                  maxY: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory BarChartWidget.sample() {
    return BarChartWidget(
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 45,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 60,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 75,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 65,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 80,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 90,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ],
    );
  }
}