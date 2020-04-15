import 'dart:convert';
import 'dart:math';

import 'package:caloriecounter/diary_entry.dart';
import 'package:caloriecounter/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {
    @override
    ChartState createState() => ChartState();
}

class ChartState extends State<Charts> {

    List<DiaryEntry> _diaryEntries = new List();
    List<charts.Series<ChartEntry, String>> seriesList;

    @override
    void initState() {
        super.initState();
        _loadDiaryEntries();
    }

    Future<Null> _loadDiaryEntries() async {
        var loadedEntries = await loadDiaryEntries();
        setState(() {
            _diaryEntries = loadedEntries;
        });
    }

    @override
    Widget build(BuildContext context) {
        seriesList = _compileChartData();
        return Container(
            color: Color(0xffabd1c6),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: charts.OrdinalComboChart(
              seriesList,
              animate: false,
              defaultRenderer: new charts.BarRendererConfig(
                  groupingType: charts.BarGroupingType.stacked,
              ),
              customSeriesRenderers: [
                  new charts.LineRendererConfig(
                      customRendererId: 'customLine',
                      includeLine: true,
                      includePoints: false,
                      dashPattern: [4, 4],
                      strokeWidthPx: 8,
                  )
              ],
//              barGroupingType: charts.BarGroupingType.stacked,
              // Add the series legend behavior to the chart to turn on series legends.
              // By default the legend will display above the chart.
              behaviors: [
                  charts.SeriesLegend(
//                      defaultHiddenSeries: ['Target'],
                      // Positions for "start" and "end" will be left and right respectively
                      // for widgets with a build context that has directionality ltr.
                      // For rtl, "start" and "end" will be right and left respectively.
                      // Since this example has directionality of ltr, the legend is
                      // positioned on the right side of the chart.
                      position: charts.BehaviorPosition.bottom,
                      // For a legend that is positioned on the left or right of the chart,
                      // setting the justification for [endDrawArea] is aligned to the
                      // bottom of the chart draw area.
                      outsideJustification: charts.OutsideJustification.middleDrawArea,
                      // By default, if the position of the chart is on the left or right of
                      // the chart, [horizontalFirst] is set to false. This means that the
                      // legend entries will grow as new rows first instead of a new column.
//                      horizontalFirst: false,
                      // By setting this value to 2, the legend entries will grow up to two
                      // rows before adding a new column.
//                      desiredMaxRows: 2,
                      // This defines the padding around each legend entry.
//                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      // Render the legend entry text with custom styles.
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.Color(r: 0, g: 30, b: 29),
//                          fontFamily: 'Georgia',
                          fontSize: 15),
                  )
              ],
          ),
        );
    }

    List<charts.Series<ChartEntry, String>> _compileChartData() {

        // 7-day outlook
        var numDataPoints = min(_diaryEntries.length, 7);

        // Trim list
        _diaryEntries = _diaryEntries.sublist(0, numDataPoints);

        // Sort such that most recent is at end
        _diaryEntries.sort((a, b) => a.date.compareTo(b.date));

        final breakfastData = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, day.totalBreakfast)
        ];

        final lunchData = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, day.totalLunch)
        ];

        final dinnerData = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, day.totalDinner)
        ];

        final otherData = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, day.totalOther)
        ];

        final targetLine = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, 1800)
        ];

        double avg = 0;
        for (var day in _diaryEntries.sublist(0, numDataPoints - 1)) {
            avg += day.totalCalories;
        }
        avg = avg / (numDataPoints - 1);

        final avgLine = [
            for (var day in _diaryEntries) ChartEntry(day.humanReadableDay, avg.round())
        ];

        return [
            charts.Series<ChartEntry, String>(
                id: 'Breakfast',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: breakfastData,
                seriesColor: charts.MaterialPalette.deepOrange.shadeDefault,
//                fillColorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
            ),

            charts.Series<ChartEntry, String>(
                id: 'Lunch',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: lunchData,
                seriesColor: charts.MaterialPalette.green.shadeDefault,
            ),

            charts.Series<ChartEntry, String>(
                id: 'Dinner',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: dinnerData,
                seriesColor: charts.MaterialPalette.blue.shadeDefault,
            ),

            charts.Series<ChartEntry, String>(
                id: 'Snacks',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: otherData,
                seriesColor: charts.MaterialPalette.indigo.shadeDefault,
            ),

            charts.Series<ChartEntry, String>(
                id: 'Target',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: targetLine,
                seriesColor: charts.MaterialPalette.red.shadeDefault,
            )
                ..setAttribute(charts.rendererIdKey, 'customLine'),

            charts.Series<ChartEntry, String>(
                id: 'Average',
                domainFn: (ChartEntry c, _) => c.date,
                measureFn: (ChartEntry c, _) => c.calories,
                data: avgLine,
                seriesColor: charts.MaterialPalette.gray.shadeDefault,
            )
                ..setAttribute(charts.rendererIdKey, 'customLine'),
        ];
    }

}

class ChartEntry {
    final String date;
    final int calories;

    ChartEntry(this.date, this.calories);
}