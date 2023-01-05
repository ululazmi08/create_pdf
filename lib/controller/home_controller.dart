import 'dart:io';
import 'dart:typed_data';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  var product = List.generate(
    25,
    (index) => {
      "id": '${index + 1}',
      "name": "Produk ke - ${index + 1}",
      'desc': DateTime.now().toString(),
    },
  );

  void getPDF() async {
    //buat class pdf
    final pdf = pw.Document();

    //buat pages
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [

            pw.Container(
              alignment: pw.Alignment.center,
              color: PdfColors.red800,
              child: pw.Text(
                'MY PRODUCTS',
                style: pw.TextStyle(
                  fontSize: 50,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              children: product
                  .map(
                    (e) => pw.Text(
                  "ID : ${e['id']} - ${e['name']}\n${e['desc']}\n\n",
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              )
                  .toList(),
            )
          ]; // Center
        },
      ),
    ); // Page

    //simpan
    // final bytes = await pdf.save();
    Uint8List bytes = await pdf.save();

    //buat file kosong di directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // timpa file kosong dengan file pdf
    file.writeAsBytes(bytes);
    print('ini berhasil ' + file.toString());

    //open pdf
    await OpenFile.open(file.path);
  }
}
