import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/work_unit.dart';

import '../../domain/entities/ride.dart';

class RidesPrintPreviewPage extends StatelessWidget {
  // 35 rides für 1 workday
  final WorkUnit workUnit;

  final String highlightHexColor = 'E8E8E8';
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('HH:mm');
  final int _flexDate = 4;
  final int _flexTime = 2;
  final int _flexDestination = 4;
  final int _flexName = 5;

  RidesPrintPreviewPage({Key? key, required this.workUnit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: _buildPdf,
      ),
    );

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

  pw.Container _buildPdf(pw.Context context) {
    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '${workUnit.monthName} ${workUnit.rides[0].start.year}\nKrankenfahrten',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 18,
            ),
          ),
          pw.SizedBox(height: 32),
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
            itemCount: workUnit.rides.length,
            itemBuilder: (pw.Context context, int index) {
              return _buildRideRow(
                  ride: workUnit.rides[index],
                  backgroundColor: index % 2 == 0
                      ? PdfColor.fromHex(highlightHexColor)
                      : null);
            },
          ),
          // pw.Divider(),
          // pw.Container(
          //   height: 16,
          //   width: double.infinity,
          //   child: pw.Text(
          //     'Gesamt: ${workUnit.rides.map((ride) => ride.price).reduce((a, b) => a + b).toString().replaceAll('.', ',')}',
          //     textAlign: pw.TextAlign.right,
          //     style: pw.TextStyle(
          //       fontWeight: pw.FontWeight.bold,
          //     ),
          //   ),
          // ),
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
              value: _dateFormatter.format(ride.start),
              flex: _flexDate,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              value: _timeFormatter.format(ride.start),
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
