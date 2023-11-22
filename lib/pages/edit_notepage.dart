// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/models/note_data.dart';

import 'package:notes_app/models/note_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = TextEditingController(text: widget.note.text);
    });
  }

  void newNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = controller.text;
    Provider.of<NoteData>(context, listen: false)
        .addNote(Note(id: id, text: text));
  }

  void updateNote(int id) {
    String text = controller.text;
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isNewNote && controller.text.isNotEmpty) {
            newNote();
          }
          if (!widget.isNewNote && controller.text.isNotEmpty) {
            updateNote(Provider.of<NoteData>(context, listen: false)
                .getAllNotes()
                .length);
          }
          Navigator.pop(context);
        },
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.save),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 24),
                  border: InputBorder.none,
                  hintText: "Enter Note"),
            ),
          ))
        ],
      )),
    );
  }
}
