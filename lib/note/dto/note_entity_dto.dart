import 'package:my_notes/note/dto/dto.dart';
import 'package:my_notes/note/exception/validate_exception.dart';
import 'package:my_notes/shared/service/string_generator.dart';

part 'note_validate.dart';

class NoteDTO extends DTO with NoteValidate {
  late String uuid;
  String title;
  String text;

  NoteDTO({
    String? uuid,
    this.title = '',
    this.text = '',
  }) {
    this.uuid = uuid ?? stringGenerator();
  }

  NoteDTO copy(){
    return NoteDTO(
      uuid: uuid,
      title: title,
      text: text
    );
  }

  @override
  void validate() {
    textValidate(text);
    titleValidate(title);
  }
}
