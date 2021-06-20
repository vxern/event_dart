import 'package:event_dart/event_dart.dart';

class Restaurant with EventEmitter {
  Future makeFood() async {
    emit('burger');
    Future.delayed(Duration(seconds: 5), () => emit('pizza'));
    Future.delayed(Duration(seconds: 10), () => emit('icecream'));
  }
}

void main() {
  final restaurant = Restaurant();

  restaurant.on('burger', () => print('Pretty good.'));
  restaurant.on('pizza', () => print('Tasty.'));
  restaurant.on('icecream', () => print('Too cold!'));

  restaurant.makeFood();
}
