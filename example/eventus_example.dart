import 'package:event_dart/event_dart.dart';

void main() {
  EventEmitter eventEmitter;

  eventEmitter.emit('emission', 'This is the emission.');
  eventEmitter.on('emission', (String r) => print(r));
}
