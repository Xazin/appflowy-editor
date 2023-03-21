import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('text_node_parser.dart', () {
    const text = 'Welcome to AppFlowy';

    test('heading style', () {
      final h1 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h1,
        },
      );
      final h2 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h2,
        },
      );
      final h3 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h3,
        },
      );
      final h4 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h4,
        },
      );
      final h5 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h5,
        },
      );
      final h6 = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.heading,
          BuiltInAttributeKey.heading: BuiltInAttributeKey.h6,
        },
      );

      expect(const TextNodeParser().transform(h1), '# $text');
      expect(const TextNodeParser().transform(h2), '## $text');
      expect(const TextNodeParser().transform(h3), '### $text');
      expect(const TextNodeParser().transform(h4), '#### $text');
      expect(const TextNodeParser().transform(h5), '##### $text');
      expect(const TextNodeParser().transform(h6), '###### $text');
    });

    test('bulleted list style', () {
      final node = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.bulletedList,
        },
      );
      expect(const TextNodeParser().transform(node), '* $text');
    });

    test('number list style', () {
      final node = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.numberList,
          BuiltInAttributeKey.number: 1,
        },
      );
      expect(const TextNodeParser().transform(node), '1. $text');
    });

    test('checkbox style', () {
      final checkbox = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.checkbox,
          BuiltInAttributeKey.checkbox: true,
        },
      );
      final unCheckbox = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.checkbox,
          BuiltInAttributeKey.checkbox: false,
        },
      );
      expect(const TextNodeParser().transform(checkbox), '- [x] $text');
      expect(const TextNodeParser().transform(unCheckbox), '- [ ] $text');
    });

    test('quote style', () {
      final node = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: BuiltInAttributeKey.quote,
        },
      );
      expect(const TextNodeParser().transform(node), '> $text');
    });

    test('code block style', () {
      final node = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.subtype: 'code_block',
        },
      );
      expect(const TextNodeParser().transform(node), '```\n$text\n```');
    });

    test('fallback', () {
      final node = TextNode(
        delta: Delta(operations: [TextInsert(text)]),
        attributes: {
          BuiltInAttributeKey.bold: true,
        },
      );
      expect(const TextNodeParser().transform(node), text);
    });

    test('TextNodeParser.id', () {
      expect(const TextNodeParser().id, 'text');
    });
  });
}
