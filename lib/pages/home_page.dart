import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/pages/edit_notepage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onCreate() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: "");
    goToNewNotePage(newNote, true);
  }

  goToNewNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                EditingNotePage(note: note, isNewNote: isNewNote)));
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).removeNote(note);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onCreate,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.add),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Notes",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              value.getAllNotes().isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(
                          child: Text(
                        "Nothing here click on + icon to add notes",
                        style: TextStyle(color: Colors.grey[400]),
                      )),
                    )
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                        value.getAllNotes().length,
                        (index) => CupertinoListTile(
                          title: Text(value.getAllNotes()[index].text),
                          onTap: () => goToNewNotePage(
                              value.getAllNotes()[index], false),
                          trailing: IconButton(
                              onPressed: () =>
                                  deleteNote(value.getAllNotes()[index]),
                              icon: const Icon(Icons.delete)),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
