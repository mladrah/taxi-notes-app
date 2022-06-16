import 'package:flutter/material.dart' hide Title;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:quiver/iterables.dart';

import '../../../../core/util/date_time_formatter.dart';
import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';

class RidesPrintPreviewPage extends StatelessWidget {
  final WorkUnit workUnit;

  final int _ridesPerPage = 35;
  final String highlightHexColor = 'E8E8E8';
  final int _flexDate = 4;
  final int _flexTime = 2;
  final int _flexDestination = 5;
  final int _flexName = 6;

  const RidesPrintPreviewPage({Key? key, required this.workUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pages = partition(workUnit.rides, _ridesPerPage);

    final doc = pw.Document();

    for (int i = 0; i < pages.length; i++) {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) => _buildPdf(context, pages.elementAt(i)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Vorschau',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (format) => doc.save(),
      ),
    );
  }

  pw.Container _buildPdf(pw.Context context, List<Ride> rides) {
    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '${workUnit.monthName} ${workUnit.rides[0].start.year}\nKrankenfahrten',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              _buildHeaderTile(
                label: 'Datum',
                flex: _flexDate,
              ),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(
                label: 'Zeit',
                flex: _flexTime,
              ),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(
                label: 'Von',
                flex: _flexDestination,
              ),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(
                label: 'Nach',
                flex: _flexDestination,
              ),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(
                label: 'Name',
                flex: _flexName,
              ),
            ],
          ),
          pw.Divider(),
          pw.ListView.builder(
            itemCount: rides.length,
            itemBuilder: (pw.Context context, int index) {
              return _buildRideRow(
                  ride: rides[index],
                  backgroundColor: index % 2 == 0
                      ? PdfColor.fromHex(highlightHexColor)
                      : null);
            },
          ),
        ],
      ),
    );
  }

  pw.Container _buildRideRow({required Ride ride, PdfColor? backgroundColor}) {
    return pw.Container(
        color: backgroundColor,
        child: pw.Row(
          children: [
            _buildRideRowTile(
              value: DateTimeFormatter.dayMonthYear(ride.start),
              flex: _flexDate,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              value: DateTimeFormatter.hourMinute(ride.start),
              flex: _flexTime,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              value: ride.fromDestination,
              flex: _flexDestination,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              value: ride.toDestination,
              flex: _flexDestination,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              value: '${ride.title == Title.herr ? 'Hr.' : 'Fr.'} ${ride.name}',
              flex: _flexName,
            ),
          ],
        ));
  }

  pw.Expanded _buildHeaderTile(
      {required String label, int? flex, pw.Alignment? alignment}) {
    return pw.Expanded(
      flex: flex ?? 1,
      child: pw.Container(
        height: 16,
        alignment: alignment ?? pw.Alignment.centerLeft,
        child: pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  pw.Expanded _buildRideRowTile(
      {required String value,
      int? flex,
      pw.Alignment? alignment,
      pw.FontWeight? fontWeight}) {
    return pw.Expanded(
      flex: flex ?? 1,
      child: pw.Container(
        height: 16,
        child: pw.FittedBox(
          alignment: alignment ?? pw.Alignment.centerLeft,
          child: pw.Text(value,
              style: pw.TextStyle(
                fontWeight: fontWeight ?? pw.FontWeight.normal,
              )),
        ),
      ),
    );
  }
}
