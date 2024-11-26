import 'dart:io';
import 'package:flutter/foundation.dart';
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
  static Future<File> generateSimpletextpdf(String text, String text2) async {
    final pdf = Document(); //creating a document
    pdf.addPage(
      Page(build: (Context context) {
        return Center(
          child: Column(
            children: [
              Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(text2,style: TextStyle(fontWeight: FontWeight.bold),),

            ]
          ),
        );
      }),
    );
    return saveandopendocument.saveDocument(name: "example.pdf", pdf: pdf);
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