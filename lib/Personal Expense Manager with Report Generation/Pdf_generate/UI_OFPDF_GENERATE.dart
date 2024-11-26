import 'package:flutter/material.dart';

import 'save_and _open_pdf.dart';

class pdf_generate extends StatefulWidget {
  const pdf_generate({super.key});

  @override
  State<pdf_generate> createState() => _pdf_generateState();
}

class _pdf_generateState extends State<pdf_generate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final simplePdffile =
                      await Simplepdfapi.generateSimpletextpdf(
                          "Hello", "World");
                  saveandopendocument.openFile(simplePdffile);
                },
                child: Text("Generate PDF"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final Pdffile = await paragraphpdfapi.generateparagraphpdf(
                      "Priyanshusatija", "Jai Shree Ram");
                  saveandopendocument.openFile(Pdffile);
                },
                child: Text("Paragraph Pdf"),
              ),
            ),

            //Table PDF created with pdf file

            Center(
                child: ElevatedButton(
              onPressed: () async {
                final tablepdf = await Tablepdfapi.generatetable();
                saveandopendocument.openFile(tablepdf);
              },
              child: Text("Table Pdf "),
            ))

            //Image Generation

            ,
            Center(
                child: ElevatedButton(
              onPressed: () async {
                final imagepdf = await ImagePdfApi.generateImagePdf();
                saveandopendocument.openFile(imagepdf);
              },
              child: Text("Image Pdf "),
            ))
          ]),
    );
  }
}

void main() {
  runApp(MaterialApp(home: pdf_generate()));
}
