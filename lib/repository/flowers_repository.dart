import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_city/data/cost.dart';
import 'package:flower_city/data/flower.dart';

Stream<List<Flower>> flowers = Stream.fromFuture(
    Future.delayed(Duration(microseconds: 200), () => tempFlowers()));

List<Flower> tempFlowers() {
  return List.generate(
    20,
    (i) => Flower(
          i,
          "assets/lilies.jpg",
          "Самый красивый цветок",
          Cost(100.0),
          "Роза кр.",
        ),
  );
}

class FlowerRepository {
  Stream<List<Flower>> getFlowers() {
    return Firestore.instance
        .collection("flowers")
        .snapshots()
        .handleError((err) => print(err.toString()))
        .map(
          (qs) { 
            var l = qs.documents.map(
                (ds) {
                  Flower f = Flower.fromMap(ds.data);
                  print(f.title);
                  return f;
                },
              );

              print(l.first.title);
              return l.toList();
          }
        );
  }
}
