import 'package:flutter/material.dart';

class TableSchdulePage extends StatelessWidget {
  const TableSchdulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: List.generate(
        DateTime.now().month <
                DateTime.now().add(const Duration(days: 32)).month
            ? DateTime.now().day
            : DateTime.now().add(const Duration(days: 32)).day,
        (index) {
          final date = DateTime.now().add(Duration(days: index));
          return TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${date.month}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${date.year}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
