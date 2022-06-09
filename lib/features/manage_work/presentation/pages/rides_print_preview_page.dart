import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../domain/entities/ride.dart';

class RidesPrintPreviewPage extends StatelessWidget {
  // 35 rides für 1 workday
  final List<Ride> rides;

  final String highlightHexColor = 'F0F0F0';
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('HH:mm');
  final int _flexName = 3;
  final int _flexDestination = 3;

  RidesPrintPreviewPage({Key? key, required this.rides}) : super(key: key);

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
            '${_dateFormatter.format(rides[0].start)} - ${_dateFormatter.format(rides[rides.length - 1].end)}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
          ),
          pw.SizedBox(height: 32),
          pw.Row(
            children: [
              _buildHeaderTile(label: 'Start'),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(label: 'Ende'),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(label: 'Name', flex: _flexName),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(label: 'Ort', flex: _flexDestination),
              pw.SizedBox(
                width: 8,
              ),
              _buildHeaderTile(label: 'Preis'),
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

  pw.Expanded _buildHeaderTile({required String label, int? flex}) {
    return pw.Expanded(
      flex: flex ?? 1,
      child: pw.Container(
        height: 16,
        child: pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  pw.Container _buildRideRow({required Ride ride, PdfColor? backgroundColor}) {
    return pw.Container(
        color: backgroundColor,
        child: pw.Row(
          children: [
            _buildRideRowTile(
              label: _timeFormatter.format(ride.start),
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              label: _timeFormatter.format(ride.end),
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              label: '${ride.title == Title.herr ? 'Hr.' : 'Fr.'} ${ride.name}',
              flex: _flexName,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              label: ride.destination,
              flex: _flexDestination,
            ),
            pw.SizedBox(
              width: 8,
            ),
            _buildRideRowTile(
              label: ride.price.toString().replaceAll('.', ','),
            ),
          ],
        ));
  }

  pw.Expanded _buildRideRowTile({required String label, int? flex}) {
    return pw.Expanded(
      flex: flex ?? 1,
      child: pw.Container(
        height: 16,
        child: pw.FittedBox(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(
            label,
          ),
        ),
      ),
    );
  }
}
