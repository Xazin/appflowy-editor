import 'package:flutter/material.dart';

import '../../../appflowy_editor.dart';
import '../text_event/text_event_handler.dart';

SelectionMenuService? _selectionMenuService;
TextEventHandler slashTextHandler = (EditorState editorState, invokee) {
  final textNodes = editorState.service.selectionService.currentSelectedNodes
      .whereType<TextNode>();
  if (textNodes.length != 1) {
    return TextEventResult.skipped;
  }

  final selection = editorState.service.selectionService.currentSelection.value;
  final textNode = textNodes.first;
  final context = textNode.context;
  final selectable = textNode.selectable;
  if (selection == null || context == null || selectable == null) {
    return TextEventResult.skipped;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _selectionMenuService =
        SelectionMenu(context: context, editorState: editorState);
    _selectionMenuService?.show();
  });

  return TextEventResult.handled;
};
