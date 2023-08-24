import 'dart:io';
import 'package:see/see.dart';
import 'package:path/path.dart';

void main(List<String> args) async {
  List<Directory> directories = getOnlyTwoDirectories(Directory.current);
  if (directories.isEmpty) {
    print("You need to have atleast two directories...");
    return;
  } else {
    String firstDirName = basename(directories[0].path);
    String secondDirName = basename(directories[1].path);

    print("Comparing $firstDirName with $secondDirName....");

    List<Future<List<File>>> futures = [
      listFiles(directories[0]),
      listFiles(directories[1])
    ];

    List<List<File>> files = await Future.wait(futures);

    if (!isEqualNumberOfFiles(files[0], files[1])) {
      print(
          "$firstDirName contains ${files[0].length} files and $secondDirName contains ${files[1].length} files");
    } else {
      print("$firstDirName and $secondDirName contain equal number of files");
      compareDirectories(files[0], files[1]);
    }
  }
}
