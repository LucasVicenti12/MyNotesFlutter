import 'package:my_notes/note/controller/database_helper.dart';
import 'package:my_notes/note/model/note_entity.dart';
import 'package:sqflite/sqflite.dart';

class NoteDAO {
  static const String noteTable = 'CREATE TABLE $_tableName('
      '$_uuid TEXT,'
      '$_title TEXT,'
      '$_text TEXT)';
  static const String _tableName = 'note';
  static const String _uuid = 'uuid';
  static const String _title = 'title';
  static const String _text = 'text';

  save(Note note) async {
    final Database database = await getDatabase();
    var haveItem = await queryNoteByUUID(note.uuid);
    if (haveItem == null) {
      return await database.insert(_tableName, toMap(note));
    } else {
      return await database.update(_tableName, toMap(note),
          where: '$_uuid = ?', whereArgs: [note.uuid]);
    }
  }

  delete(String noteUUID) async {
    final Database database = await getDatabase();
    return database
        .delete(_tableName, where: '$_uuid = ?', whereArgs: [noteUUID]);
  }

  Future<Note?> queryNoteByUUID(String noteUUID) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tableName,
      where: '$_uuid = ?',
      whereArgs: [noteUUID],
    );
    return toNote(result);
  }

  Future<List<Note>> queryAllNotes() async {
    final Database database = await getDatabase();
    return toNoteList(await database.query(_tableName));
  }

  Map<String, dynamic> toMap(Note note) {
    final Map<String, dynamic> noteMap = {};
    noteMap[_uuid] = note.uuid;
    noteMap[_title] = note.title;
    noteMap[_text] = note.text;
    return noteMap;
  }

  List<Note> toNoteList(List<Map<String, dynamic>> notes) {
    return notes
        .map((e) => Note(uuid: e[_uuid], title: e[_title], text: e[_text]))
        .toList();
  }

  Note? toNote(List<Map<String, dynamic>> notes) {
    return notes
        .map((e) => Note(uuid: e[_uuid], title: e[_title], text: e[_text]))
        .firstOrNull;
  }
}
