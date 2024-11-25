import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package

void main() {
  runApp(MyApp());
}

// Main app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarChartPage(), // The BarChartPage is our main page
    );
  }
}

// Page that displays the bar chart
class BarChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Chart Example'), // App bar title
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add padding around the chart
        child: BarChartSample(), // The custom bar chart widget
      ),
    );
  }
}

// Custom widget for the bar chart
class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData( // Main bar chart data configuration
        barGroups: getBarGroups(), // Sets the bar data
        titlesData: FlTitlesData(
          // Customizes chart titles (axes labels)
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false, // Hide top axis labels
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false, // Hide right axis labels
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, // Display bottom axis titles
              getTitlesWidget: (double value, TitleMeta meta) {
                // Display bottom labels dynamically based on bar position
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Label ${value.toInt() + 1}',
                    style: const TextStyle(fontSize: 6),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false), // Hide the border around the chart
        gridData: const FlGridData(show: false), // Hide the grid lines
      ),
      // Updated curve and duration
      duration: const Duration(milliseconds: 800), // Set animation duration
      curve: Curves.easeInOut, // Set animation curve
    );
  }

  // Function that defines the data for the bars
  List<BarChartGroupData> getBarGroups() {
    // List of bar chart data groups
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 18, color: Colors.blue)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 20, color: Colors.green)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.orange)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.red)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: Colors.purple)]),
    ];
  }
}
