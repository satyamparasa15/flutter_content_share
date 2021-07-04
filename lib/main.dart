import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_content/file_preview.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Share content app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  String subject = '';
  List<String> filePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content share plugin"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Share text:',
                  hintText: 'Enter some text and/or link to share',
                ),
                maxLines: 2,
                onChanged: (String value) => setState(() {
                  text = value;
                }),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Share subject:',
                  hintText: 'Enter subject to share (optional)',
                ),
                maxLines: 2,
                onChanged: (String value) => setState(() {
                  subject = value;
                }),
              ),
              const Padding(padding: EdgeInsets.only(top: 12.0)),
              FilePreview(filePaths, onDelete: _onDeleteFile),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Attachment'),
                onTap: () async {
                  addAttachments();
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 12.0)),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: text.isEmpty && filePaths.isEmpty
                        ? null
                        : () => _onShare(context),
                    child: const Text('Share'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addAttachments() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
    );
    if (result != null) {
      PlatformFile fileList = result.files.first;
      setState(() {
        filePaths.add(fileList.path);
      });
    } else {
      print("No file selected");
    }
  }

  void _onShare(BuildContext context) async {
    if (filePaths.isNotEmpty) {
      await Share.shareFiles(
        filePaths,
        text: text,
        subject: subject,
      );
    } else {
      await Share.share(
        text,
        subject: subject,
      );
    }
  }

  void _onDeleteFile(int position) {
    setState(() {
      filePaths.removeAt(position);
    });
  }
}
