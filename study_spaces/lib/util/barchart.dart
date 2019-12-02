/// Bar chart example
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
//  factory BarChart.withRandomData() {
//    return new BarChart(_createRandomData());
//  }
//
//  /// Create random data.
//  static List<charts.Series<StudyHours, String>> _createRandomData() {
//    final random = new Random();
//
//    final data = [
//      new StudyHours('2014', random.nextInt(100)),
//      new StudyHours('2015', random.nextInt(100)),
//      new StudyHours('2016', random.nextInt(100)),
//      new StudyHours('2017', random.nextInt(100)),
//    ];
//
//    return [
//      new charts.Series<StudyHours, String>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (StudyHours sales, _) => sales.weekDay,
//        measureFn: (StudyHours sales, _) => sales.hoursStudied,
//        data: data,
//      )
//    ];
//  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<StudyHours, String>> _createSampleData() {
    final data = [
      new StudyHours('Monday', 5),
      new StudyHours('Tuesday', 0),
      new StudyHours('Wednesday', 10),
      new StudyHours('Thursday', 7),
      new StudyHours('Friday', 5),
      new StudyHours('Saturday', 2),
      new StudyHours('Sunday', 11),
    ];

    return [
      new charts.Series<StudyHours, String>(
        id: 'Study',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (StudyHours sales, _) => sales.weekDay,
        measureFn: (StudyHours sales, _) => sales.hoursStudied,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class StudyHours {
  final String weekDay;
  final int hoursStudied;

  StudyHours(this.weekDay, this.hoursStudied);
}