import 'dart:io';

List<File> listFiles(Directory dir) {
  List<File> fileList = [];

  dir.listSync(recursive: true).forEach((FileSystemEntity entity) {
    if (entity is File) {
      fileList.add(entity);
    }
  });

  return fileList;
}

void main(List<String> args) {
  if (args.isNotEmpty) {}
}
