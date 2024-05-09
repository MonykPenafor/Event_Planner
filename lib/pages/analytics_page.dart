import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsPage extends StatelessWidget {
  final List<charts.Series<dynamic, String>> barChartData;
  final List<charts.Series<dynamic, DateTime>> lineChartData;
  final bool animate;

  // Modified constructor using initializer list for default values
  AnalyticsPage({
    List<charts.Series<dynamic, String>>? barChartData,
    List<charts.Series<dynamic, DateTime>>? lineChartData,
    this.animate = false,
  })  : barChartData = barChartData ?? _createBarChartData(),
        lineChartData = lineChartData ?? _createLineChartData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.BarChart(
                barChartData,
                animate: animate,
              ),
            ),
            Expanded(
              child: charts.TimeSeriesChart(
                lineChartData,
                animate: animate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for the bar chart
  static List<charts.Series<EventCount, String>> _createBarChartData() {
    final data = [
      EventCount('Conference', 5),
      EventCount('Wedding', 8),
      EventCount('Birthday', 3),
    ];

    return [
      charts.Series<EventCount, String>(
        id: 'Events',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EventCount events, _) => events.type,
        measureFn: (EventCount events, _) => events.count,
        data: data,
      )
    ];
  }

  // Sample data for the line chart
  static List<charts.Series<TimeSeriesEventCount, DateTime>> _createLineChartData() {
    final data = [
      TimeSeriesEventCount(DateTime(2024, 1, 1), 5),
      TimeSeriesEventCount(DateTime(2024, 2, 1), 25),
      TimeSeriesEventCount(DateTime(2024, 3, 1), 100),
    ];

    return [
      charts.Series<TimeSeriesEventCount, DateTime>(
        id: 'Monthly Events',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesEventCount event, _) => event.time,
        measureFn: (TimeSeriesEventCount event, _) => event.count,
        data: data,
      )
    ];
  }
}

// Model class for bar chart data
class EventCount {
  final String type;
  final int count;

  EventCount(this.type, this.count);
}

// Model class for line chart data
class TimeSeriesEventCount {
  final DateTime time;
  final int count;

  TimeSeriesEventCount(this.time, this.count);
}
