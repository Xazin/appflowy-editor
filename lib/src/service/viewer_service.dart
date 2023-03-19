import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

class AppFlowyViewer extends StatefulWidget {
  AppFlowyViewer({
    Key? key,
    required this.editorState,
    this.shrinkWrap = false,
    this.customBuilders = const {},
    ThemeData? themeData,
  }) : super(key: key) {
    this.themeData = themeData ??
        ThemeData.light().copyWith(extensions: [
          ...lightEditorStyleExtension,
          ...lightPlguinStyleExtension,
        ]);
  }

  final EditorState editorState;

  /// Render plugins.
  final NodeWidgetBuilders customBuilders;

  /// Renders in a ScrollView if false
  final bool shrinkWrap;

  late final ThemeData themeData;

  @override
  State<AppFlowyViewer> createState() => _AppFlowyViewerState();
}

class _AppFlowyViewerState extends State<AppFlowyViewer> {
  Widget? services;

  @override
  void initState() {
    super.initState();

    editorState.themeData = widget.themeData;
    editorState.service.renderPluginService = _createRenderPlugin();
  }

  @override
  void didUpdateWidget(covariant AppFlowyViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (editorState.service != oldWidget.editorState.service) {
      editorState.service.renderPluginService = _createRenderPlugin();
    }

    editorState.themeData = widget.themeData;
    services = null;
  }

  @override
  Widget build(BuildContext context) {
    return services ??= _buildServices(context);
  }

  EditorState get editorState => widget.editorState..editable = false;

  EditorStyle get editorStyle =>
      editorState.themeData.extension<EditorStyle>() ?? EditorStyle.light;

  bool get shrinkWrap => widget.shrinkWrap;

  Widget _buildParent(Widget child) {
    if (!shrinkWrap) {
      return AppFlowyScroll(
        key: editorState.service.scrollServiceKey,
        child: Container(
          color: editorStyle.backgroundColor,
          padding: editorStyle.padding!,
          child: child,
        ),
      );
    }

    return Container(
      color: editorStyle.backgroundColor,
      padding: editorStyle.padding!,
      child: child,
    );
  }

  Widget _buildServices(BuildContext context) {
    return Theme(
      data: widget.themeData,
      child: _buildParent(
        AppFlowySelection(
          key: editorState.service.selectionServiceKey,
          editable: false,
          editorState: editorState,
          child: editorState.service.renderPluginService.buildPluginWidget(
            NodeWidgetContext(
              context: context,
              node: editorState.document.root,
              editorState: editorState,
            ),
          ),
        ),
      ),
    );
  }

  AppFlowyRenderPlugin _createRenderPlugin() => AppFlowyRenderPlugin(
        editorState: editorState,
        builders: {
          ...defaultBuilders,
          ...widget.customBuilders,
        },
      );
}
