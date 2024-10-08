import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../infra/testable_editor.dart';

const _padding = 24.0;

void main() async {
  group('indentCommand - widget test indent padding', () {
    testWidgets("indent LTR line under LTR line", (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('Hello', blockComponentTextDirectionLTR),
        ('Will indent this', blockComponentTextDirectionLTR),
      );

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, _padding);
      expect(nestedBlock?.indentPadding.right, 0);

      await editor.dispose();
    });

    testWidgets("indent LTR line under RTL line", (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionRTL),
        ('Will indent this', blockComponentTextDirectionLTR),
      );

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, _padding);
      expect(nestedBlock?.indentPadding.right, 0);

      await editor.dispose();
    });

    testWidgets("indent RTL line under RTL line", (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionRTL),
        ('خط دوم', blockComponentTextDirectionRTL),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    testWidgets("indent RTL line under LTR line", (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('Hello', blockComponentTextDirectionLTR),
        ('خط دوم', blockComponentTextDirectionRTL),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    testWidgets("indent AUTO line under AUTO line", (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionAuto),
        ('خط دوم', blockComponentTextDirectionAuto),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    // TODO(.): The purpose of this test is to catch addPostFrameCallback from
    //  calculateTextDirection but it doesn't catch it. Commenting the callback
    //  out doesn't make this test fail.
    testWidgets(
        "indent AUTO line under AUTO line changing the second line calculated direction",
        (tester) async {
      final editor = await indentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionAuto),
        ('س', blockComponentTextDirectionAuto),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      Node node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      final selection = Selection.single(
        path: [0, 0],
        startOffset: 0,
        endOffset: 1,
      );
      await editor.updateSelection(selection);
      await editor.ime.typeText('a');

      node = editor.nodeAtPath([0])!;
      final nestedBlockAfter = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlockAfter?.indentPadding.left, _padding);
      expect(nestedBlockAfter?.indentPadding.right, 0);

      await editor.dispose();
    });
  });
  group('indentCommand (multi-line) - widget test multi-line indent padding',
      () {
    testWidgets("indent 2 LTR lines under LTR line", (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('Hello', blockComponentTextDirectionLTR),
        ('Will indent this', blockComponentTextDirectionLTR),
        ('Third Line', blockComponentTextDirectionLTR),
      );

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, _padding);
      expect(nestedBlock?.indentPadding.right, 0);

      await editor.dispose();
    });

    testWidgets("indent two LTR lines under RTL line", (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionRTL),
        ('Will indent this', blockComponentTextDirectionLTR),
        ('Third Line', blockComponentTextDirectionLTR),
      );

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, _padding);
      expect(nestedBlock?.indentPadding.right, 0);

      await editor.dispose();
    });

    testWidgets("indent two RTL lines under RTL line", (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionRTL),
        ('خط دوم', blockComponentTextDirectionRTL),
        ('خط سوم', blockComponentTextDirectionRTL),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    testWidgets("indent two RTL lines under LTR line", (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('Hello', blockComponentTextDirectionLTR),
        ('خط دوم', blockComponentTextDirectionRTL),
        ('خط سوم', blockComponentTextDirectionRTL),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    testWidgets("indent one RTL line and one LTR line under LTR line",
        (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('Hello', blockComponentTextDirectionLTR),
        ('خط دوم', blockComponentTextDirectionRTL),
        ('Third Line', blockComponentTextDirectionLTR),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });

    testWidgets("indent one LTR line and one RTL lines under RTL line",
        (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionRTL),
        ('Will indent this', blockComponentTextDirectionLTR),
        ('خط سوم', blockComponentTextDirectionRTL),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, _padding);
      expect(nestedBlock?.indentPadding.right, 0);

      await editor.dispose();
    });

    testWidgets("indent AUTO line under AUTO line", (tester) async {
      final editor = await multiLineIndentTestHelper(
        tester,
        ('سلام', blockComponentTextDirectionAuto),
        ('خط دوم', blockComponentTextDirectionAuto),
        ('خط سوم', blockComponentTextDirectionAuto),
      );

      await editor.pressKey(key: LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      final node = editor.nodeAtPath([0])!;
      final nestedBlock = node.key.currentState!
          .unwrapOrNull<NestedBlockComponentStatefulWidgetMixin>();

      expect(nestedBlock?.indentPadding.left, 0);
      expect(nestedBlock?.indentPadding.right, _padding);

      await editor.dispose();
    });
  });
}

typedef TestLine = (String, String);

Future<TestableEditor> indentTestHelper(
  WidgetTester tester,
  TestLine firstLine,
  TestLine secondLine,
) async {
  final editor = tester.editor
    ..addNode(paragraphNode(text: firstLine.$1, textDirection: firstLine.$2))
    ..addNode(paragraphNode(text: secondLine.$1, textDirection: secondLine.$2));
  await editor.startTesting();

  final selection = Selection.collapsed(
    Position(path: [1], offset: 1),
  );
  await editor.updateSelection(selection);

  await editor.pressKey(key: LogicalKeyboardKey.tab);
  await tester.pumpAndSettle();

  final node = editor.nodeAtPath([0])!;
  expect(node.delta?.toPlainText(), firstLine.$1);
  expect(node.children.first.level, 2);

  return editor;
}

Future<TestableEditor> multiLineIndentTestHelper(
  WidgetTester tester,
  TestLine firstLine,
  TestLine secondLine,
  TestLine thirdLine,
) async {
  final editor = tester.editor
    ..addNode(paragraphNode(text: firstLine.$1, textDirection: firstLine.$2))
    ..addNode(paragraphNode(text: secondLine.$1, textDirection: secondLine.$2))
    ..addNode(paragraphNode(text: thirdLine.$1, textDirection: thirdLine.$2));
  await editor.startTesting();

  final selection = Selection(
    start: Position(path: [1], offset: 1),
    end: Position(path: [2], offset: 1),
  );
  await editor.updateSelection(selection);

  await editor.pressKey(key: LogicalKeyboardKey.tab);
  await tester.pumpAndSettle();

  final node = editor.nodeAtPath([0])!;
  expect(node.delta?.toPlainText(), firstLine.$1);
  expect(node.children.every((element) => element.level == 2), true);

  return editor;
}
