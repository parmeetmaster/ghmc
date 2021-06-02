import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePick {
  Future<File>? pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    return File((result!.files.first.path)!);
  }
}
