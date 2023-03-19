import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../infra/test_editor.dart';

void main() {
  group('TextCommands extension tests', () {
    testWidgets('insertText', (tester) async {
      final editor = tester.editor
        ..insertEmptyTextNode()
        ..insertTextNode('World');

      await editor.startTesting();

      editor.editorState.insertText(0, 'Hello', path: [0]);
      await tester.pumpAndSettle();

      expect(
        (editor.editorState.getTextNode(path: [0]).delta.first as TextInsert)
            .text,
        'Hello',
      );
    });

    testWidgets('insertTextAtCurrentSelection', (tester) async {
      final editor = tester.editor..insertTextNode('Helrld!');

      await editor.startTesting();

      final selection = Selection(
        start: Position(path: [0], offset: 3),
        end: Position(path: [0], offset: 3),
      );

      await editor.updateSelection(selection);

      editor.editorState.insertTextAtCurrentSelection('lo Wo');
      await tester.pumpAndSettle();

      expect(
        (editor.editorState.getTextNode(path: [0]).delta.first as TextInsert)
            .text,
        'Hello World!',
      );
    });
  });
}
