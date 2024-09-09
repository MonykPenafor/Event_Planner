import 'package:event_planner/models/event.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../services/event_services.dart';
import '../../services/user_services.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<Map<String, int>> _eventCategoryCounts;

  @override
  void initState() {
    super.initState();
    _eventCategoryCounts = getEventCategoryCounts();
  }

  Future<Map<String, int>> getEventCategoryCounts() async {
    
    Map<String, int> mapmap = {};

    final eventServices = Provider.of<EventServices>(context, listen: false);
    final userServices = Provider.of<UserServices>(context, listen: false);
    
    final userId = userServices.appUser?.id;
    List<Event> firebaseEvents = await eventServices.fetchEventsList(userId);

    for(Event e in firebaseEvents){
      if (e.type != null) {
        if (mapmap.containsKey(e.type)) {
          mapmap[e.type!] = (mapmap[e.type!] ?? 0) + 1;
        } else {
          mapmap[e.type!] = 1;
        }
      }
    }

    return mapmap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, int>>(
          future: _eventCategoryCounts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data available"));
            }

            return buildCategoryPieChart(snapshot.data!);
          },
        ),
      ),
    );
  }

  Widget buildCategoryPieChart(Map<String, int> categoryData) {
    List<charts.Series<MapEntry<String, int>, String>> seriesList = [
      charts.Series<MapEntry<String, int>, String>(
        id: 'Categories',
        data: categoryData.entries.toList(),
        domainFn: (entry, _) => entry.key, // A categoria
        measureFn: (entry, _) => entry.value, // A quantidade
        labelAccessorFn: (entry, _) => '${entry.key}: ${entry.value}',
        colorFn: (_, index) => charts.MaterialPalette.blue.makeShades(categoryData.length)[index!],
      )
    ];

    return charts.PieChart<String>(
      seriesList,
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );
  }
}
