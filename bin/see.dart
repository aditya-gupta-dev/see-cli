import 'dart:io';
import 'package:see/see.dart';

void main(List<String> args) {
  String path = "H:\\darting\\see\\lib";

  List<Directory> directories = getOnlyTwoDirectories(Directory(path));
  if (directories.isEmpty) {
    print("You need to have atleast two directories...");
    return;
  }
}
