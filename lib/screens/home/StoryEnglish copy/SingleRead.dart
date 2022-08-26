import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SingleRead extends StatefulWidget {
  SingleRead({Key? key}) : super(key: key);

  @override
  SingleReadState createState() => SingleReadState();
}

class SingleReadState extends State<SingleRead> {
  final FlutterTts flutterTts = FlutterTts();
  Future _speakk(String text) async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  Future<void> _extractAllText() async {
    PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('sample.pdf'));
    PdfTextExtractor extractor = PdfTextExtractor(document);
    String text = extractor.extractText();
    _showResult(text);
    //  _speakk(text);
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  void _showResult(String text) {
    _speakk(text);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Extracted text'),
            content: Scrollbar(
              child: SingleChildScrollView(
                child: Text(text),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
              ),
            ),
            actions: [
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _speakk("Closed");
                },
              )
            ],
          );
        });
  }
}
