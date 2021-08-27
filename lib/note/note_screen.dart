import 'package:flutter/material.dart';
import 'package:flutter_note_app/home/home_screen.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  NoteScreen({Key key, this.note}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () => Navigator.pop(context, widget.note)),
        title: Text(
          widget.note != null ? 'Edit Note' : 'New Note',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Note\'s title',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    controller: contentController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Note\'s content',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  if (contentController.text.isNotEmpty) {
                    final content = contentController.text;
                    final title = titleController.text.isNotEmpty
                        ? titleController.text
                        : 'New Note';
                    Navigator.of(context)
                        .pop(Note(title: title, content: content));
                  } else {
                    showGeneralDialog(
                        context: context,
                        pageBuilder: (context, _, __) => Dialog(
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'NOTE',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20.0),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Please add note content\nto continue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.0),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  }
                },
                child: Text(
                  widget.note != null ? 'SAVE' : 'ADD NOTE',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
