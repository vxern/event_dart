# Create an event emitter and listen for events

## Usage

You can use strings to identify the event, and provide additional data separately:

```dart
// to subscribe:
emitter.on('success', (String r) => doStuff(r));
// to emit:
emitter.emit('success', result_var);
```
