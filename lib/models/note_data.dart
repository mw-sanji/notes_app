import 'package:flutter/material.dart';
import 'package:notes_app/data/hive_database.dart';
import 'package:notes_app/models/note_model.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();
  List<Note> _notes = [
    Note(id: 0, text: "FirstNote"),
    Note(id: 1, text: "SecondNote")
  ];
  void initializeNotes() {
    _notes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return _notes;
  }

  void addNote(Note note) {
    _notes.add(note);
    db.saveNote(_notes);
    notifyListeners();
  }

  void updateNote(Note note, String text) {
    for (int i = 0; i < _notes.length; i++) {
      if (_notes[i].id == note.id) {
        _notes[i].text = text;
      }
    }
    db.saveNote(_notes);
    notifyListeners();
  }

  void removeNote(Note note) {
    _notes.remove(note);
    db.saveNote(_notes);
    notifyListeners();
  }
}
