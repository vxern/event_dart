mixin EventEmitter {
  /// Mapping of events to a list of event handlers
  final Map<String, List<Function>> recurrentEvents = {};

  /// Mapping of events to a list of one-time event handlers
  final Map<String, List<Function>> singleEvents = {};

  /// This function triggers all the handlers currently listening
  /// to `event` and passes them `data`
  void emit(String event, [List arguments = const []]) {
    if (!singleEvents.containsKey(event)) {
      if (recurrentEvents.containsKey(event)) {
        recurrentEvents[event]!.forEach((handler) => handler());
      }

      return;
    }

    singleEvents[event]!.forEach((handler) => handler());
    singleEvents.remove(event);
  }

  /// This function binds the `handler` as a listener to the `event`
  void on(String event, Function handler) {
    if (recurrentEvents.containsKey(event)) {
      recurrentEvents[event]!.add(handler);
    } else {
      recurrentEvents[event] = [handler];
    }
  }

  /// This function binds the `handler` as listener to the first
  /// occurrence of the `event`. When `handler` is called once,
  /// it is removed.
  void once(String event, Function handler) {
    if (singleEvents.containsKey(event)) {
      singleEvents[event]!.add(handler);
    } else {
      singleEvents[event] = [handler];
    }
  }

  /// This function attempt to remove all handlers from the `event`.
  void clearListeners() {
    recurrentEvents.clear();
    singleEvents.clear();
  }
}
