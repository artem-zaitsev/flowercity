import 'package:flower_city/data/cost.dart';


///
///Модель цветка(Product)
///
class Flower {
  final int id;
  final String imageUrl;
  final String desc;
  final Cost cost;
  final String title;

  Flower(this.id, this.imageUrl, this.desc, this.cost, this.title);

  Flower.fromMap(
    Map<String, dynamic> map
  ) : this(
    map["id"],
    map["image"],
    map["desc"],
    Cost(map["cost"]*1.0),
    map["name"],
  );
}
