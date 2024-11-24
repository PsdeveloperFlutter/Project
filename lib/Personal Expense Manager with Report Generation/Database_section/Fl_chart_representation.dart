import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Import Random

void main() {
  runApp(MaterialApp(home:  FlChartRepresentation()));
}
class FlChartRepresentation extends StatefulWidget {
  const FlChartRepresentation({Key? key}) : super(key: key);

  @override
  _FlChartRepresentationState createState() => _FlChartRepresentationState();
}

class _FlChartRepresentationState extends State<FlChartRepresentation> {
  int touchedIndex = -1;

  // Mock data for the chart
  late final List<double> monthlyExpenses;

  @override
  void initState() {
    super.initState();
    // Generate random values between 0 and 100
    monthlyExpenses = List.generate(12, (index) => Random().nextDouble() * 100);

    // Debug print to check generated values
    print("Monthly Expenses: $monthlyExpenses");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${getMonthName(group.x)}\n',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: 'Priyanshu',
                              style: const TextStyle(color: Colors.yellow),
                            ),
                          ],
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      setState(() {
                        if (response != null && response.spot != null) {
                          touchedIndex = response.spot!.touchedBarGroupIndex;
                        } else {
                          touchedIndex = -1;
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final month = getMonthName(value.toInt());
                          return Text(
                            month,
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                    ),
                  ),
                  barGroups: monthlyExpenses
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          fromY: entry.value.isNaN ? 0 : entry.value,
                          color: touchedIndex == entry.key ? Colors.orange : Colors.blue, toY:0
                        ),
                      ],
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int index) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[index];
  }
}
