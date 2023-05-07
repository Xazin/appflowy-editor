import 'package:appflowy_editor/src/infra/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rich_clipboard/rich_clipboard.dart';
import 'package:rich_clipboard_platform_interface/rich_clipboard_platform_interface.dart';

class MockRichBlipboardPlatform extends RichClipboardPlatform {
  String? text;
  String? html;

  MockRichBlipboardPlatform({
    this.text,
    this.html,
  });

  @override
  Future<List<String>> getAvailableTypes() async {
    return [];
  }

  @override
  Future<RichClipboardData> getData() async {
    return RichClipboardData(text: text, html: html);
  }

  @override
  Future<void> setData(RichClipboardData data) async {
    html = data.html;
    text = data.text;
  }
}

void main() {
  setUp(() {
    RichClipboardPlatform.instance = MockRichBlipboardPlatform();
  });

  group('Clipboard tests', () {
    test('AppFlowyClipboardData constructor', () {
      const data = AppFlowyClipboardData(text: null, html: null);

      expect(data.text, null);
      expect(data.html, null);
    });

    testWidgets('AppFlowyClipboard setData and getData', (tester) async {
      const rawText = "Hello World";

      await RichClipboard.setData(const RichClipboardData(text: rawText));
      final clipboardData = await RichClipboard.getData();

      expect(clipboardData.text, rawText);
    });

    test('AppFlowyClipboard setData w/ HTML', () async {
      const rawHTML = "<html><body><p>Hello world!</p></body></html>";

      await RichClipboard.setData(
        const RichClipboardData(html: rawHTML),
      );

      final clipboardData = await RichClipboard.getData();

      expect(clipboardData.html, rawHTML);
    });
  });
}
