mixin EventEmitter {
  /// Mapping of events to a list of events handlers.
  var events = <String, List<Function>>{};

  /// Mapping of events to a list of one-time event handlers.
  var events_once = <String, List<Function>>{};

  /// This function triggers all the handlers currently listening
  /// to `event` and passes them `data`.
  void emit(String event, [argument_1, argument_2, argument_3]) =>
      events.forEach((key, value) {
        if (key == event) {
          value.forEach((element) {
            callHandler(element, argument_1, argument_2, argument_3);
          });
        }
      });

  /// Helper function to call the handler with the correct number of arguments.
  void callHandler(Function handler, argument_1, argument_2, argument_3) {
    if (argument_1 == null) {
      handler();
    } else if (argument_2 == null) {
      handler(argument_1);
    } else if (argument_3 == null) {
      handler(argument_1, argument_2);
    } else {
      handler(argument_1, argument_2, argument_3);
    }
  }

  /// This function binds the `handler` as a listener to the `event`.
  void on(String event, Function handler) {
    events.putIfAbsent(event, () => <Function>[]);
    events.forEach((key, value) {
      if (key == event) {
        value.add(handler);
      }
    });
  }

  /// This function binds the `handler` as listener to the first
  /// occurrence of the `event`. When `handler` is called once,
  /// it is removed.
  void once(String event, Function handler) {
    events_once.putIfAbsent(event, () => <Function>[]);
    events_once.forEach((key, value) {
      if (key == event) {
        value.add(handler);
      }
    });
  }

  /// This function attempts to unbind the `handler` from the `event`.
  void removeListener(String event, Function handler) {
    events.forEach((key, value) {
      if (key == event) {
        events[key] = value.where((h) => h != handler).toList();
      }
    });
    events_once.forEach((key, value) {
      if (key == event) {
        events_once[key] = value.where((h) => h != handler).toList();
      }
    });
  }

  /// This function attempt to remove all handlers from the `event`.
  void clearListeners() {
    events.clear();
    events_once.clear();
  }

  /// Returns a list of listeners for the specified event.
  List<Function> listeners(String event) {
    var result = <Function>[];

    events.forEach((key, value) {
      if (key == event) {
        result.addAll(value);
      }
    });

    events_once.forEach((key, value) {
      if (key == event) {
        result.addAll(value);
      }
    });

    return result;
  }
}
