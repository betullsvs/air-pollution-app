import 'package:flutter/material.dart';

import '../helper/air_quality_helper.dart';

class AirQualityTable extends StatelessWidget {
  final Map<String, dynamic> components;

  const AirQualityTable({super.key, required this.components});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(
              color: const Color.fromARGB(255, 255, 255, 255), width: 3),
          columnWidths: const {
            0: FixedColumnWidth(120),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
          },
          children: [
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Bileşenler',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Değerler',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Durum',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                ),
              ],
            ),
            ...components.entries.map((entry) {
              var colorAndDescription = AirQualityHelper.getColorAndDescription(
                  entry.key, entry.value.toDouble());

              Color cellColor = colorAndDescription['color'];
              String status = colorAndDescription['description'];

              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.key.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      color: cellColor,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
