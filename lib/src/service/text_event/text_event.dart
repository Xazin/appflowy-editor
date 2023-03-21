import 'text_event_handler.dart';

class TextEvent {
  const TextEvent({
    required this.invoker,
    required this.handler,
  });

  /// The text used to invoke the handler,
  /// eg. "/" for slash-menu or "@" for mentions
  final String invoker;

  final TextEventHandler handler;
}
