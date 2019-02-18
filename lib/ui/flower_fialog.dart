import 'package:flower_city/data/flower.dart';
import 'package:flower_city/di/injector.dart';
import 'package:flutter/material.dart';

class FlowerBottomSheet extends StatelessWidget {
  final Flower flower;

  const FlowerBottomSheet({Key key, this.flower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
      child: Container(
        height: 500.0,
        padding: EdgeInsets.all(16.0),
        color: Colors.amberAccent,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                flower.imageUrl,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Add to Cart"),
                onPressed: () {
                  Injector.cartBloc.addToCart(flower);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(flower.title),
                Text("${flower.cost.cost} ${flower.cost.symbol}")
              ],
            ),
            Text(
              flower.desc,
              style: TextStyle(
                fontSize: 24.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
