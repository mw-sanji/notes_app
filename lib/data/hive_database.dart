import 'package:hive/hive.dart';
import 'package:notes_app/models/note_model.dart';

class HiveDatabase {
  final _myBox = Hive.box("note_database");
  List<Note> loadNotes() {
    List<Note> savednotesFormatted = [];
    if (_myBox.get("All_notes") != null) {
      List<dynamic> savedNotes = _myBox.get("All_notes");
      for (int i = 0; i < savedNotes.length; i++) {
        Note note = Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        savednotesFormatted.add(note);
      }
    }
    return savednotesFormatted;
  }

  void saveNote(List<Note> notes) {
    List<List<dynamic>> allNotesFormatted = [];
    for (var note in notes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    _myBox.put("All_notes", allNotesFormatted);
  }
}
