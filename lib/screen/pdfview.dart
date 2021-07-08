import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:materi_ipa/bloc/PdfBloc.dart';
import 'package:materi_ipa/utils/Utils.dart';
import 'package:materi_ipa/utils/color_code.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Pdfview extends StatefulWidget {
  final url;
  String fileName;
  Pdfview(this.url, this.fileName);

  @override
  _PdfviewState createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  // PDFDocument document;
  String url = "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf";
  PdfBloc bloc = new PdfBloc();
  Directory rootPath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFileFromUrl(context, url).then((value){
      if(value != null) {
        bloc.changeDoc(value);
      }
    });
    
    bloc.fileFetcher.listen((file) {
      if(file != null){
        Utils.showConfirmDialog(context, 'Informasi', "File berhasil didownload, apakah anda ingin melihat file sekarang?", () {
          // OpenFile.open(file.path);
        });
      }
    });
  }

  Widget inbox() {
    return InkWell(
      onTap: ()async{
        // bloc.donwloadFile(context, widget.url, '${widget.code}.pdf');
        if(bloc.dataFile != null){
          // OpenFile.open(bloc.dataFile.path);
        }
      },
      child: new Container(
        margin: EdgeInsets.only(bottom: 60, right: 15),
        child: FloatingActionButton(
          onPressed: null,
          tooltip: 'Inbox',
          child: Center(child: Icon(Icons.cloud_download)),
        ),
      ),
    );
  }

  Future<File> getFileFromUrl(BuildContext context, String url, {name}) async {
    try {
      // Utils.progressDialog(context);
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      Directory dir = await getTemporaryDirectory();
      // var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/test.pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pop();
      return urlFile;
    } catch (e) {
      // Navigator.of(context).pop();
      Utils.alertError(context, 'File tidak ditemukan', () { });
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:Utils.colorFromHex(ColorCode.lightBlueDark),
      appBar: AppBar(
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
        ),
        title: Text('File ${widget.fileName}'),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: bloc.fileDoc,
                  builder: (context, snapshot) {
                    File data = File('');
                    if(snapshot.data != null){
                      data = snapshot.data as File;
                    }
                    return data.path != '' ? Stack(
                      children: [
                        Container(
                          child: PDFView(
                            filePath: data.path,
                            autoSpacing: true,
                            enableSwipe: true,
                            pageSnap: true,
                            swipeHorizontal: true,
                            nightMode: false,
                            onError: (e) {
                              //Show some error message or UI
                            },
                            onRender: (_pages) {
                              // setState(() {
                              //   _totalPages = _pages;
                              //   pdfReady = true;
                              // });
                            },
                            onViewCreated: (PDFViewController vc) {
                              // setState(() {
                              //   _pdfViewController = vc;
                              // });
                            },
                            onPageChanged: (page, total){

                            },
                            // onPageChanged: (int page, int total) {
                            //   // setState(() {
                            //   //   _currentPage = page;
                            //   // });
                            // },
                            onPageError: (page, e) {},
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: inbox(),
                        )
                      ],
                    ): Center(child: CircularProgressIndicator());
                  }
              ),
            ),
          ],
        ),
      )
      // isLoading ? Center(child: CircularProgressIndicator()):
        // Stack(
        //   children: <Widget>[
        //     // Container(
        //     //   child: PDFViewer(
        //     //     document: document,
        //     //     zoomSteps: 1,
        //     //   ),
        //     // ),
        //     Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: inbox(),
        //     )
        //   ],
        // ),
    );
  }
  // loadDocument() async {
  //   // String urlDownload = '${API.BASE_URL}/invoice/download/${widget.orderCode}';
  //   // String urlShow = '${API.BASE_URL}/invoice/show/${widget.orderCode}';
  //   if (Platform.isAndroid) {
  //     rootPath = await getExternalStorageDirectory();
  //   } else if (Platform.isIOS) {
  //     rootPath = await getApplicationDocumentsDirectory();
  //   }//getTemporaryDirectory();
  //   // print('PDF ${urlDownload}');
  //   document = await PDFDocument.fromURL(widget.url);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
}
