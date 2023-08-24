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

List<Directory> getOnlyTwoDirectories(Directory directory) {
  List<Directory> directories = [];
  List<FileSystemEntity> entities = directory.listSync();
  for (FileSystemEntity entity in entities) {
    if (entity is Directory) {
      directories.add(entity);
    }
  }
  return directories.getRange(0, 2).toList();
}
