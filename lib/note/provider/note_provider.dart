import 'package:flutter/cupertino.dart';
import 'package:my_notes/note/controller/note_dao.dart';
import 'package:my_notes/note/dto/note_entity_dto.dart';
import 'package:my_notes/note/model/note_entity.dart';

class NoteProvider extends ChangeNotifier {
  final NoteDAO noteDAO = NoteDAO();

  void save(NoteDTO noteDTO) {
    var note = Note(uuid: noteDTO.uuid, title: noteDTO.title, text: noteDTO.text);
    noteDAO.save(note);
    notifyListeners();
  }
  Future<List<Note>> listAll() async {
    return await noteDAO.queryAllNotes();
  }
  void remove(Note note) {
    noteDAO.delete(note.uuid);
    notifyListeners();
  }
}
