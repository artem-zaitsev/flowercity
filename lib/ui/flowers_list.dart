import 'dart:ui';

import 'package:flower_city/data/flower.dart';
import 'package:flower_city/di/injector.dart';
import 'package:flower_city/ui/flower_fialog.dart';
import 'package:flutter/material.dart';

class FlowersScreen extends StatefulWidget {
  @override
  _FlowersScreenState createState() => _FlowersScreenState();
}

class _FlowersScreenState extends State<FlowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FlowerCity",
        ),
        actions: <Widget>[
          StreamBuilder<int>(
            initialData: 0,
            stream: Injector.cartBloc.productsInCartCount,
            builder: (BuildContext context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(snapshot.data.toString()),
                      top: 2.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      tooltip: 'Air it',
                      onPressed: () {},
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Flower>>(
        initialData: <Flower>[],
        stream: Injector.flowerRepository.getFlowers(),
        builder: (BuildContext context, snapshot) {
          return _buildGridView(snapshot);
        },
      ),
    );
  }

  Widget _buildGridView(AsyncSnapshot<List<Flower>> snapshot) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          key: ValueKey(
            snapshot.data[index].id,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(6.0),
            highlightColor: Colors.indigo,
            onTap: () {
              showDialog(snapshot, index, context);
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                SizedBox.expand(
                  child: Image.network(
                    snapshot.data[index].imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 15.0),
                  child: Container(
                    constraints: BoxConstraints.expand(height: 32.0),
                      color: Colors.transparent,
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 32.0),
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data[index].title),
                      Text(
                          "${snapshot.data[index].cost.cost} ${snapshot.data[index].cost.symbol}")
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  Future showDialog(
      AsyncSnapshot<List<Flower>> snapshot, int index, BuildContext context) {
    return showModalBottomSheet(
      builder: (ctx) => FlowerBottomSheet(
            flower: snapshot.data[index],
          ),
      context: context,
    );
  }
}
