import 'package:event_emitter/event_emitter.dart';

void main() {
  EventEmitter eventEmitter;

  eventEmitter.emit('emission', 'This is the emission.');
  eventEmitter.on('emission', (String r) => print(r));
}
