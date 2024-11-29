import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart'; // Import the GetX package

// Page that displays the bar chart
class BarChartPage extends StatefulWidget {
  final RxList<dynamic> storevalue; // Corrected type and syntax

  BarChartPage({required this.storevalue}); // Constructor to receive data

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph Represention '), // Displaying the amount in the title
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChartSample(storevalue: widget.storevalue),
      ), // Pass data to BarChartSample
    );
  }
}

// Custom widget for the bar chart
class BarChartSample extends StatefulWidget {
  final RxList<dynamic> storevalue; // Corrected type

  BarChartSample({required this.storevalue});

  @override
  State<BarChartSample> createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: getBarGroups(), // Set the bar data
        titlesData: FlTitlesData(
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
                    '${widget.storevalue[value.toInt()].category}',
                    style: const TextStyle(fontSize: 12,fontWeight:FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true
        ,border: Border.all(color: Colors.black,width: 2),
        ), // Hide the border around the chart
        gridData:  FlGridData(show: true,

        ), // Hide the grid lines
      ),
      // Set animation duration and curve
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  // Function that defines the data for the bars
  List<BarChartGroupData> getBarGroups() {
    // Create a list of BarChartGroupData objects dynamically from storevalue
    return List.generate(widget.storevalue.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: LinearGradient(colors: [Colors.yellow.shade500, Colors.cyan]),
            toY: widget.storevalue[index].amount.toDouble(), // Ensure it's a double
            color: index%2==0 ? Colors.green.shade500 : Colors.cyan,
          ),
        ],
      );
    });
  }
}
