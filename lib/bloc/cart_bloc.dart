import 'dart:async';

import 'package:flower_city/data/cart.dart';
import 'package:flower_city/data/flower.dart';

class CartBloc {
  final myCart = Cart(Map());
  StreamController<Cart> _controller = StreamController<Cart>.broadcast();

  Stream<int> get productsInCartCount =>
      _controller.stream.map((c) => c.productToCount.keys.length);

  Stream<Cart> get cart => _controller.stream;

  StreamSink<Cart> get _addToCart => _controller.sink;

  Stream<double> get summaryCost => cart.map(
        (c) => c.productToCount
            .map((f, count) => MapEntry(f, f.cost.cost * count))
            .values
            .fold(0, (d1, d2) => d1 + d2),
      );

  CartBloc() {
    _controller.sink.add(myCart);
  }

  addToCart(Flower f) {
    _addToCart.add(myCart..productToCount[f] = 1);
  }

  dispose() {
    _controller.close();
  }
}
