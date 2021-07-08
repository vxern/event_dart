mixin EventEmitter {
  /// Mapping of events to a list of event handlers
  final Map<String, List<Function>> recurrentEvents = {};

  /// Mapping of events to a list of one-time event handlers
  final Map<String, List<Function>> singleEvents = {};

  /// This function triggers all the handlers currently listening
  /// to `event` and passes them `arguments`
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

  /// Bind the `handler` as listener to a single
  /// occurrence of the `event`.
  void once(String event, Function handler) {
    if (singleEvents.containsKey(event)) {
      singleEvents[event]!.add(handler);
    } else {
      singleEvents[event] = [handler];
    }
  }

  /// Remove all handlers from an event
  void clearListener(String event) {
    recurrentEvents.remove(event);
    singleEvents.remove(event);
  }

  /// Remove all events and their handlers
  void clearListeners() {
    recurrentEvents.clear();
    singleEvents.clear();
  }
}
