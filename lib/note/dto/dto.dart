import 'package:my_notes/note/exception/validate_exception.dart';

abstract class DTO {
  void validate();

  bool isValid() {
    try {
      validate();
      return true;
    } on ValidateException {
      return false;
    }
  }
}