import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

Future<void> main() async {
  final root = Directory.current;
  final lib = Directory(path.join(root.path, 'lib'));
  final projectName = await getProjectName(root);
  print(projectName);
  //createExport(lib, lib, fileName: projectName, skipChildren: true);
}

Future<bool> createExport(Directory root, Directory dir,
    {String? fileName, bool skipChildren = false}) async {
  final children = [];
  final dirs = [];
  for (final file in dir.listSync()) {
    if (file is Directory) {
      final has = await createExport(root, file);
      if (has) {
        dirs.add(path.basename(file.path));
      }
    } else if (!skipChildren) {
      if (file.path.endsWith('.dart') &&
          !file.path.endsWith('.web.dart') &&
          !await hasPartOf(file as File)) {
        children.add(file.path);
      }
    }
  }

  if (children.isEmpty && dirs.isEmpty) {
    return false;
  }

  final dirName = fileName ?? path.basename(dir.path);
  final exportFileName = '$dirName.dart';
  final exportFile = File(path.join(dir.path, exportFileName));
  final exportParts = [];
  for (final child in children) {
    final basename = path.basename(child);
    if (basename != exportFileName) {
      exportParts.add("export '$basename';");
    }
  }
  for (final d in dirs) {
    exportParts.add("export '$d/$d.dart';");
  }
  exportParts.sort();
  final sb = StringBuffer();
  exportParts.forEach(sb.writeln);
  sb.writeln();
  exportFile.writeAsStringSync(sb.toString());
  print('Created: ${exportFile.path.substring(root.path.length + 1)}');
  return true;
}

Future<String> getProjectName(Directory root) async {
  final lines = File(path.join(root.path, 'pubspec.yaml'))
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  final name = await lines.firstWhere((line) => line.startsWith('name:'));
  return name.split(':').last.trim();
}

Future<bool> hasPartOf(File file) async {
  return file
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .any((line) => line.startsWith('part of'));
}
