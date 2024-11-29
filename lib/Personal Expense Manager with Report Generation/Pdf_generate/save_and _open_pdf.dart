/// This file contains the functions for saving and opening a PDF file. The
/// functions are:
///   - `saveDocument`: This function takes a name and a PDF document as
///     parameters and saves the PDF document to a file.
///   - `openFile`: This function takes a file as a parameter and opens the file.

/// The `saveDocument` function takes a name and a PDF document as parameters and
/// saves the PDF document to a file.
/// The `openFile` function takes a file as a parameter and opens the file.

/// The `Simplepdfapi` class contains the `generateSimpletextpdf` function which
/// takes two strings as parameters and generates a PDF document with the two
/// strings as content.
/// The `paragraphpdfapi` class contains the `generateparagraphpdf` function which
/// takes two strings as parameters and generates a PDF document with the two
/// strings as content. The PDF document also contains a header, a headline and
/// a link.
/// The `Tablepdfapi` class contains the `generatetable` function which takes a
/// list of users as a parameter and generates a PDF document with a table
/// containing the users' names and ages.
/// The `ImagePdfApi` class contains the `generateImagePdf` function which
/// generates a PDF document with two images. The images are loaded from the
/// assets folder of the Flutter project.
///
///
///
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
class saveandopendocument {

  //This function is used to save a pdf file
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getApplicationSupportDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  //This function is for the opening of the saved pdf file
  static Future<void> openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}





class Simplepdfapi {
  static Future<File> generateSimpletextpdf(String text, String text2,String text3) async {
    final pdf = Document(); //creating a document
    pdf.addPage(
      Page(build: (Context context) {
        return Center(
          child: Column(
              children: [
                Text("Description ${text3}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 40)),
                Text("Category ${text2}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 40),),
                Text("Price ${text}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 30),),
              ]
          ),
        );
      }),
    );
    return saveandopendocument.saveDocument(name: "example_kk.pdf", pdf: pdf);
  }
}




class paragraphpdfapi{
  static Future<File> generateparagraphpdf(String text, String text2) async {
    final pdf = Document(); //creating a document

    pdf.addPage(
        MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (Context context) =>[
              customheader(),
              customheadline(),
              createlink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize:30)),
                  SizedBox(height: 0.5*PdfPageFormat.cm),
                  Text(text2,style: TextStyle(fontWeight: FontWeight.bold,fontSize:30)),
                  SizedBox(height: 0.5*PdfPageFormat.cm),
                  Text("This is a Paragraph",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30)),
                ],
              ),
              Header(
                  text:"Pdf Paragraph",
                  textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,)
              ),
              Paragraph(
                  text: LoremText().paragraph(60),
                  style:  TextStyle(fontWeight: FontWeight.bold,fontSize:15)
              ),
              Paragraph(
                  text: LoremText().paragraph(60),
                  style:  TextStyle(fontWeight: FontWeight.bold,fontSize:15)
              ),
              Paragraph(
                  text: LoremText().paragraph(60),
                  style:  TextStyle(fontWeight: FontWeight.bold,fontSize:15)
              ),
            ],
            header: (context)=> buildPageNumber(context),
            footer: (context)=>buildPageNumber(context)
        )
    );

    return saveandopendocument.saveDocument(name: "Paragraph_pdf.pdf", pdf: pdf);
  }

  static Widget customheader() {

    return Container(
        padding: EdgeInsets.only(bottom: 3*PdfPageFormat.mm),
        decoration: const BoxDecoration(
            border: Border(
                bottom:BorderSide(width:2,color:PdfColors.white)
            )
        ),
        child: Row(
            children: [
              PdfLogo(),
              SizedBox(width: 0.5*PdfPageFormat.cm),
              Text("Create your Pdf ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:50))
            ]
        )
    );
  }

  static Widget customheadline() {
    return Header(
        child: Text("Another headline",style: TextStyle(fontWeight: FontWeight.bold,fontSize:50)
        ),padding:const EdgeInsets.all(8.0),decoration: const BoxDecoration(color: PdfColors.red));
  }

  static Widget createlink() {
    return UrlLink(
      child: Text(
          "Go to heyflutter.com"
          ,style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: PdfColors.blue)),destination: 'http://heyflutter.com',
    );
  }

  static  Widget buildPageNumber(pw.Context context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:10),
        child: Text(
            'Page ${
                context.pageNumber} of ${
                context.pagesCount
            }',
            style: TextStyle(fontSize:12,fontWeight:FontWeight.bold))
    );

  }

}


//This for the table creation and for the table pdf
class Tablepdfapi{

  static Future<File> generatetable()async{
    final pdf=Document();
    final header=['Name','age'];
    final users=[
      User(name: 'James', age: 24),
      User(name: 'Thomas', age: 50),
      User(name: 'Fralklin', age: 29),
    ];
    final data=users.map((user)=>[user.name,user.age]).toList();

    pdf.addPage(
      Page(
          build:(context)=>TableHelper.fromTextArray(
              data:data,
              headers:header,
              cellAlignment: Alignment.center,
              tableWidth: TableWidth.max,
              border:TableBorder.all(width: 5),
              headerStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
              cellStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)
          )
      ),
    );
    return saveandopendocument.saveDocument(name: 'table_pdf.pdf', pdf: pdf);
  }

}



class User {
  final String  name;
  final int age;
  User({
    required this.name , required this.age
  });
}


//This is code is Responsible for the image PDF file


class ImagePdfApi {
  static Future<File> generateImagePdf() async {
    try {
      // Load Images
      final Uint8List image1 = (await rootBundle.load('assets/images/car image.png')).buffer.asUint8List();
      final Uint8List image2 = (await rootBundle.load('assets/images/car1.jpeg')).buffer.asUint8List();

      // Create PDF Document
      final pdf = pw.Document();

      final pageTheme = pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        buildBackground: (context) {
          if (context.pageNumber == 2) {
            return pw.FullPage(
              ignoreMargins: true,
              child: pw.Image(pw.MemoryImage(image1), fit: pw.BoxFit.cover),
            );
          }
          return pw.Container();
        },
      );

      pdf.addPage(
        pw.MultiPage(
          pageTheme: pageTheme,
          build: (context) => [
            pw.Image(pw.MemoryImage(image1)),
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image2),
                width: pageTheme.pageFormat.availableWidth / 2,
                height: 600,
                alignment: pw.Alignment.center,
              ),
            ),
            pw.ClipRRect(
              verticalRadius: 32,
              horizontalRadius: 32,
              child: pw.Image(pw.MemoryImage(image1)),
            ),
          ],
        ),
      );

      // Save and return PDF file
      return await saveAndOpenDocument(name: 'example.pdf', pdf: pdf);
    } catch (e) {
      print("Error generating PDF: $e");
      rethrow;
    }
  }

  static Future<File> saveAndOpenDocument({required String name, required pw.Document pdf}) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$name");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
