import 'dart:convert';
import 'dart:io';

String toCamelCase(String iconName) {
  return iconName
      .replaceAllMapped(
          RegExp(
              r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
          (m) => '${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}')
      .replaceAll(RegExp(r'(_|-|\s)+'), '');
}

Future<void> main() async {
  await File.fromUri(Uri.file('assets/icons/icomoon.json'))
      .readAsString()
      .then((fileContents) => json.decode(fileContents))
      .then(
    (jsonData) {
      final output = [
        '// ignore_for_file: constant_identifier_names',
        'part of themes;',
        '',
        'class CSIcons {',
        '  CSIcons._();',
        '',
        "  static const _kFont = 'IcoMoon';",
        '',
      ];
      final icons = List<Map<String, dynamic>>.from(
          jsonData['iconSets'][0]['selection'] as List<dynamic>);

      for (final icon in icons) {
        output.add(
          '''  static const IconData ${toCamelCase(icon['name'].toString())} = IconData(0x${icon['code'].toRadixString(16)}, fontFamily: _kFont);''',
        );
      }

      output.add('}');

      return File('lib/themes/icons.dart').writeAsString(output.join('\n'));
    },
  );
}
