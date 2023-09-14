part of 'note_entity_dto.dart';

mixin NoteValidate {
  void titleValidate(String title) {
    if (title.isEmpty) {
      throw 'Inform the title'.asExtension;
    }
  }
  void textValidate(String text){
    if(text.isEmpty || text == ''){
      throw 'Inform the text'.asExtension();
    }
  }
}
