import '../../../appflowy_editor.dart';

enum TextEventResult {
  handled,
  skipped,
}

typedef TextEventHandler = TextEventResult Function(
  EditorState editorState,
  String? textInserted,
);
