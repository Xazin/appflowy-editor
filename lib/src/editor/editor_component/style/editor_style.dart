import 'package:appflowy_editor/appflowy_editor.dart';

import 'package:flutter/material.dart';

/// The style of the editor.
///
/// You can customize the style of the editor by passing the [EditorStyle] to
///  the [AppFlowyEditor].
///
class EditorStyle {
  const EditorStyle({
    required this.padding,
    EdgeInsets? headerPadding,
    EdgeInsets? footerPadding,
    required this.cursorColor,
    required this.selectionColor,
    required this.textStyleConfiguration,
    required this.textSpanDecorator,
    this.defaultTextDirection,
  })  : headerPadding = headerPadding ?? padding,
        footerPadding = footerPadding ?? padding;

  /// The padding of the editor.
  final EdgeInsets padding;

  /// The padding of the header.
  /// Defaults to [padding]
  final EdgeInsets? headerPadding;

  /// The padding of the header.
  /// Defaults to [padding]
  final EdgeInsets? footerPadding;

  /// The cursor color
  final Color cursorColor;

  /// The selection color
  final Color selectionColor;

  /// Customize the text style of the editor.
  ///
  /// All the text-based components will use this configuration to build their
  ///   text style.
  ///
  /// Notes, this configuration is only for the common config of text style and
  ///   it maybe override if the text block has its own [BlockComponentConfiguration].
  final TextStyleConfiguration textStyleConfiguration;

  /// Customize the built-in or custom text span.
  ///
  /// For example, you can add a custom text span for the mention text
  ///   or override the built-in text span.
  final TextSpanDecoratorForAttribute? textSpanDecorator;

  final String? defaultTextDirection;

  const EditorStyle.desktop({
    EdgeInsets? padding,
    EdgeInsets? headerPadding,
    EdgeInsets? footerPadding,
    Color? cursorColor,
    Color? selectionColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    this.defaultTextDirection,
  })  : padding = padding ?? const EdgeInsets.symmetric(horizontal: 100),
        headerPadding = headerPadding ??
            padding ??
            const EdgeInsets.symmetric(horizontal: 100),
        footerPadding = footerPadding ??
            padding ??
            const EdgeInsets.symmetric(horizontal: 100),
        cursorColor = cursorColor ?? const Color(0xFF00BCF0),
        selectionColor =
            selectionColor ?? const Color.fromARGB(53, 111, 201, 231),
        textStyleConfiguration = textStyleConfiguration ??
            const TextStyleConfiguration(
              text: TextStyle(fontSize: 16, color: Colors.black),
            ),
        textSpanDecorator =
            textSpanDecorator ?? defaultTextSpanDecoratorForAttribute;

  const EditorStyle.mobile({
    EdgeInsets? padding,
    EdgeInsets? headerPadding,
    EdgeInsets? footerPadding,
    Color? cursorColor,
    Color? selectionColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    this.defaultTextDirection,
  })  : padding = padding ?? const EdgeInsets.symmetric(horizontal: 20),
        headerPadding = headerPadding ??
            padding ??
            const EdgeInsets.symmetric(horizontal: 20),
        footerPadding = footerPadding ??
            padding ??
            const EdgeInsets.symmetric(horizontal: 20),
        cursorColor = cursorColor ?? const Color(0xFF00BCF0),
        selectionColor =
            selectionColor ?? const Color.fromARGB(53, 111, 201, 231),
        textStyleConfiguration = textStyleConfiguration ??
            const TextStyleConfiguration(
              text: TextStyle(fontSize: 16, color: Colors.black),
            ),
        textSpanDecorator =
            textSpanDecorator ?? mobileTextSpanDecoratorForAttribute;

  EditorStyle copyWith({
    EdgeInsets? padding,
    EdgeInsets? headerPadding,
    EdgeInsets? footerPadding,
    Color? cursorColor,
    Color? selectionColor,
    TextStyleConfiguration? textStyleConfiguration,
    TextSpanDecoratorForAttribute? textSpanDecorator,
    String? defaultTextDirection,
  }) {
    return EditorStyle(
      padding: padding ?? this.padding,
      headerPadding: headerPadding ?? this.headerPadding,
      footerPadding: footerPadding ?? this.footerPadding,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionColor: selectionColor ?? this.selectionColor,
      textStyleConfiguration:
          textStyleConfiguration ?? this.textStyleConfiguration,
      textSpanDecorator: textSpanDecorator ?? this.textSpanDecorator,
      defaultTextDirection: defaultTextDirection,
    );
  }
}
