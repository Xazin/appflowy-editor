import 'package:flutter/material.dart';

import 'package:appflowy_editor/appflowy_editor.dart';

/// [AppFlowyKeyboardService] is responsible for processing shortcut keys,
///   like command, shift, control keys.
///
/// Usually, this service can be obtained by the following code.
/// ```dart
/// final keyboardService = editorState.service.keyboardService;
///
/// /** Simulates shortcut key input*/
/// keyboardService?.onKey(...);
///
/// /** Enables or disables this service */
/// keyboardService?.enable();
/// keyboardService?.disable();
/// ```
///
abstract class AppFlowyKeyboardService {
  /// Enables shortcuts service.
  void enable();

  /// Disables shortcuts service.
  ///
  /// In some cases, if your custom component needs to monitor
  ///   keyboard events separately,
  ///   you can disable the keyboard service of flowy_editor.
  /// But you need to call the `enable` function to restore after exiting
  ///   your custom component, otherwise the keyboard service will fails.
  void disable({
    bool showCursor = false,
    UnfocusDisposition disposition = UnfocusDisposition.scope,
  });

  /// Enables the service to be able to request focus.
  ///
  void enableFocus();

  /// Disables the service from being able to request focus.
  ///
  void disableFocus();

  /// Closes the keyboard
  ///
  /// Used in mobile
  void closeKeyboard();

  /// Enable the keyboard in mobile
  ///
  /// Used in mobile
  void enableKeyBoard(Selection selection);
}
