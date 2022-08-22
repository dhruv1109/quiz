import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'speech_text.dart';

class read extends StatefulWidget {
  @override
  _readState createState() => _readState();
}

class _readState extends State<read> {
  final FlutterTts flutterTts = FlutterTts();
  Future _speakk(String text) async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Extract all text',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _extractAllText,
              color: Colors.blue,
            ),
            FlatButton(
              child: Text(
                'Extract text from a specific page',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _extractTextFromSpecificPage,
              color: Colors.blue,
            ),
            FlatButton(
              child: Text(
                'Extract text from a range of pages',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _extractTextFromRangeOfPage,
              color: Colors.blue,
            ),
            Card(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpeechText()),
                      );
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Progress'),
                        ])))
          ],
        ),
      ),
    );
  }

  Future<void> _extractAllText() async {
    //Load the existing PDF document.
    PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('sample.pdf'));

    //Create the new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract all the text from the document.
    String text = extractor.extractText();

    //Display the text.
    _showResult(text);
    //  _speakk(text);
  }

  Future<void> _extractTextFromSpecificPage() async {
    //Load the existing PDF document.
    PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('sample.pdf'));

    //Create the new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract all the text from the first page of the PDF document.
    String text = extractor.extractText(startPageIndex: 1);

    //Display the text.
    _showResult(text);
    // _speakk(text);
  }

  Future<void> _extractTextFromRangeOfPage() async {
    //Load the existing PDF document.
    PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('sample.pdf'));

    //Create the new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract all the text from the first page to 3rd page of the PDF document.
    String text = extractor.extractText(startPageIndex: 0, endPageIndex: 1);

    //Display the text.
    _showResult(text);
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
