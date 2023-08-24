import 'dart:io';
import 'package:path/path.dart' as path;

Future<List<File>> listFiles(Directory dir) async {
  await Future.delayed(Duration(seconds: 2));
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
  if (directories.length >= 2) {
    return directories.getRange(0, 2).toList();
  }
  return [];
}

Future compareDirectories(List<File> first, List<File> second) async {
  bool result = await isInitialNamesEqual(first, second);
  if (result) {
    print("Both had identical file names");
    List<Future<bool>> futures = [];
    for (int i = 0; i < first.length; i++) {
      futures.add(isEqualContentInFile(first[i], second[i]));
    }
    List<bool> results = await Future.wait(futures);

    bool areAllFilesEqual = true;
    for (bool result in results) {
      if (!result) {
        areAllFilesEqual = false;
      }
    }

    if (areAllFilesEqual) {
      print("Both Directories were identical");
    }
  }
}

Future<bool> isEqualContentInFile(File first, File second) async {
  String contentInFirstFile = await first.readAsString();
  String contentInSecondFile = await second.readAsString();

  String firstName = path.basename(first.path);

  if (contentInFirstFile == contentInSecondFile) {
    print("content of both $firstName are equal");
    return true;
  } else {
    print("content of both $firstName is not equal");
    return false;
  }
}

bool isEqualNumberOfFiles(List<File> first, List<File> second) {
  return first.length == second.length;
}

Future<bool> isInitialNamesEqual(List<File> first, List<File> second) async {
  for (int i = 0; i < first.length; i++) {
    String firstname = path.basename(first[i].path);
    String secondname = path.basename(second[i].path);
    if (firstname != secondname) {
      print("$firstname is not equal to $secondname");
      return false;
    }
  }
  return true;
}
