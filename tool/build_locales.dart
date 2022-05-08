import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, env;
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logger/logger.dart';

class ProdLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

final log = Logger(
  printer: SimplePrinter(),
  filter: ProdLogFilter(),
);

final accountCredentials = ServiceAccountCredentials.fromJson({
  'type': 'service_account',
  'private_key_id': 'bd3a5e7ec7c93e940a305b73fe08a04a64b6cfda',
  'private_key':
      '-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDjEuzih+jnCwnz\nvo/WmUbgR974N9dRhwfJs1YDnntDYcu5psyeDxEpaf7ZSatWU9xi19h/qr1rD2RQ\njZMV8Y5fSaFe/U1nDaceSBWpoPHMIW52PQ/rd7A5qxXunTRTCw6mXtMvPzzHAjjw\naCzfzR72ACeKZ8b4+CSb8QzLSZ2+5yvwqgzeiIYNCQ0YopV5xtB8fhHMG51L+x1F\nMl2x3A3t4Z1FnbTgzi/zLPzB+HXJG11hrOxFOVGdD6BcbwUu/obg60PMPRR4mPvO\n3v0fVfpAlLPi21ydPUqK1YrushMzw17pEWWZhPxRxvLezZenmIeH5B0lyS5GMwf7\nc4pI5zfXAgMBAAECggEAQ9/E0gOpAOLCU0rbSNyhHGovQkfCwzpXABnsdIF7O81w\nLWqnz/kV+qiVxlJodhH0FtGJA8RAAU/k/tUKqaz+Dwp9w1x4tfyVPw5x9zXGAOvf\nTlV7PDmXAe3bTOtNmCL+eolum7lNy/ikl2u0OiNghUzPhOX3SjU2ECzR07QKBGUa\nEHhfiFYdp6dKoAA9w6u4DzX5UzB/jbPRejGSKCBVw7kjHOf6cHjRVfUTW/Wcj4NZ\njt0LxZoYZ+iotlHFR9crq1ld9/IgBOlW6o96dlJFAs20hPHUO38N0YPmJVD0g42n\nQnczNXabdaBbYJUnr30IKlOfAkTgSTDhRKoAPU6qiQKBgQDxnzEBzugZ08SF5i8z\ndPsD7YlhYldrnT2gTifYESIAsZgK/RCqucw2BbFIs85lAEchsi/kRUhnhijY1rjU\nQTzd/629NA3uKk9vs1CeC44rFSXebR8VquO6bKuvXnh4ZmV7WIMv9mTnwzn8NvnR\nqJv9TS8GWjwKRYejyXv67xjuPwKBgQDwlh1Pji8Ws6Ol6P1LgNpcT1Ao4WUtqVaR\nJhKxC2BsuWkPuzQtgKivAQIgIQxceVlpFphoTC7OMFF+MLP+jkmF+xvA2Tk4GrBy\n4XghBNV+bubAC7BUmUXpKEMs3VHXiWPjwlblXrqHM4oU99ZHbavoMRQx+NCLuxQ7\nVIxvN/KAaQKBgQDq95g83e0wUJPocrSsIbKJW1Ih9fR1nm/zmI1+vQqICiyFYxv2\nKsDAOEDzJogsCF0kE5gnMIj8w6atWAJdxyNd7+oQ+LIjTdn6EjLvvuT+WI5/Azcb\nZxgWjt9Wp1QYIdvGW4kX91ChYWTeNMg0bvdjGNAGKXIBuyPwz1tV53YjGQKBgQDk\nKeloTnbX98vGh7zYgz4Td2CVNJVpBYTEqS/m2dw7oGdD9Q1Z7f+L4M/sOotnk+o4\noKYvm7hz8R0IKRY63yRZPTkn3prGW4FlofD0l4oFmxWZojw7LxU/NuDmRorcdz7V\nfLQ+WWVa3YUht51vJlJ3JTx62/aj3eslDV0WCSAhqQKBgGa2pZo9EDVUtg+JVK3S\n2u4A0D2ihN50oGYs7JQ646Lb+3NX3sMb1iam7d/BHTdfctGOoQ2N13lmu+tau2wY\ncemyWXFwSR5PpV12Xq2PZO9CJS027nEfjHSjjV4HYCqHWvgNTd7S+LrLaDnVgzco\nQyNS5A5hb8tJFzq5jo6X3v5t\n-----END PRIVATE KEY-----\n',
  'client_email': 'translation@lomocoin-179802.iam.gserviceaccount.com',
  'client_id': '104524835908471204608',
});

Future<void> downloadTranslations(SheetsApi api) async {
  load('.env.locales');

  final spreadsheetId = env['TRANSLATION_DOC_ID'];
  final localeSheets = env['TRANSLATION_SHEETS'].split('|');
  final localeLanguages = env['TRANSLATION_LANGUAGES'].split('|');

  log.d('Open Doc: $spreadsheetId');

  final doc = await api.spreadsheets.get(spreadsheetId);

  // Initialize Languages
  final translations = localeLanguages
      .map((lang) => {
            lang: {},
          })
      .fold({}, (previousValue, element) => {...previousValue, ...element});

  if (doc.sheets.isEmpty) {
    throw Exception('No namespaces sheets');
  }

  for (final sheet in doc.sheets) {
    final sheetName = sheet.properties.title;
    log.i('Process Sheet: $sheetName');

    if (localeSheets.contains(sheetName)) {
      final docValues = await api.spreadsheets.values
          .get(spreadsheetId, '$sheetName!A1:F1000');

      for (final row in docValues.values) {
        for (final lang in localeLanguages.asMap().entries) {
          try {
            if (row.isNotEmpty && row[0] != 'Key') {
              final transKey = '$sheetName:${row[0]}';
              translations[lang.value][transKey] = row[lang.key + 1] ?? '';
            }
          } catch (e) {
            log.e(
              'Error processing "$sheetName" row: ${row.toList()}',
              e.toString(),
            );
          }
        }
      }
    }
  }

  for (final lang in localeLanguages) {
    final file = File('assets/locales/$lang.json');
    await file.create(recursive: true);
    final encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(translations[lang]), flush: true);
  }

  log.d('Translations updated! Bye bye');
}

Future<void> main() async {
  final client = await clientViaServiceAccount(
    accountCredentials,
    [
      SheetsApi.SpreadsheetsScope,
    ],
  );

  final sheetsApi = SheetsApi(client);

  await downloadTranslations(sheetsApi);

  client.close();
}
