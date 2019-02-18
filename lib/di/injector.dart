import 'package:flower_city/bloc/cart_bloc.dart';
import 'package:flower_city/repository/flowers_repository.dart';

class Injector {

  static CartBloc cartBloc = CartBloc();

  static FlowerRepository flowerRepository = FlowerRepository();
  
}