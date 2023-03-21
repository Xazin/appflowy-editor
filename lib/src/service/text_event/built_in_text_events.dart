import 'package:appflowy_editor/src/service/interna_text_event_handlers/slash_handler.dart';
import 'package:appflowy_editor/src/service/text_event/text_event.dart';

List<TextEvent> builtInTextEvents = [
  TextEvent(
    invoker: '/',
    handler: slashTextHandler,
  ),
];
