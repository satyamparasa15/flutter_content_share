import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilePreview extends StatelessWidget {
  final List<String> filePaths;

  final Function(int) onDelete;

  const FilePreview(this.filePaths, {Key key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filePaths.isEmpty) {
      return Container();
    }
    final fileWidgets = <Widget>[];
    for (var i = 0; i < filePaths.length; i++) {
      fileWidgets.add(_FilePreview(
        filePaths[i],
        onDelete: onDelete != null ? () => onDelete(i) : null,
      ));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: fileWidgets),
    );
  }
}

class _FilePreview extends StatelessWidget {
  final String filePath;
  final VoidCallback onDelete;

  const _FilePreview(this.filePath, {Key key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(),
            child: Container(
              height: 100,
              color: Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(filePath),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: 30,
                child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: onDelete,
                    child: Icon(Icons.delete)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
