import 'package:fit_check/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  static String routeName = '/details-page';
  const LineChartWidget({super.key});

  @override
  LineChartSample2State createState() => LineChartSample2State();
}

class LineChartSample2State extends State<LineChartWidget> {

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                color: appColor),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                  showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: (value, meta) {
              String monthNameShort="";
              switch (value.toInt()) {
                case 2:
                  monthNameShort= 'MAR';
                  break;
                case 5:
                  monthNameShort= 'APR';
                  break;
                case 8:
                  monthNameShort= 'MAY';
                  break;
              }
              return Text(monthNameShort, style: TextStyle(color: Colors.white),);
            },
          )
        ),
        leftTitles: AxisTitles(

          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              String leftText="";
              switch (value.toInt()) {
                case 1:
                   leftText='85';
                   break;
                case 3:
                   leftText='75';
                   break;
                case 5:
                   leftText='65';
                   break;
              }
              return Text(leftText, style: TextStyle(color: Colors.white),);
            },
            reservedSize: 32,
          )
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.white,
            width: 2,
          )),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2.6, 1),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 2.6),
            FlSpot(11, 4.5),
          ],
          isCurved: true,
          color: Colors.green,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color:Colors.lightGreenAccent.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}